return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  opts = function()

    require("mason").setup()
    local mason_registry = require("mason-registry")
  
    local cmd = { vim.fn.exepath("jdtls") }
    print(mason_registry.get_all_package_names()[0])

    local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"
    table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))

    return {
      -- How to find the root dir for a given filename. The default comes from
      -- lspconfig which provides a function specifically for java projects.
      root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

      -- How to find the project name for a given root dir.
      project_name = function(root_dir)
        return root_dir and vim.fs.basename(root_dir)
      end,

      -- Where are the config and workspace dirs for a project?
      jdtls_config_dir = function(project_name)
        return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
      end,
      jdtls_workspace_dir = function(project_name)
        return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
      end,

      -- How to run jdtls. This can be overridden to a full java command-line
      -- if the Python wrapper script doesn't suffice.
      cmd = cmd,

      full_cmd = function(opts)
        local root_dir = opts.root_dir
        local project_name = opts.project_name(root_dir)
        local full_cmd = vim.deepcopy(opts.cmd)
        if project_name then
          vim.list_extend(full_cmd, {
            "-configuration",
            opts.jdtls_config_dir(project_name),
            "-data",
            opts.jdtls_workspace_dir(project_name),
          })
        end
        return full_cmd
      end,

      -- These depend on nvim-dap, but can additionally be disabled by setting false here.
      dap = { hotcodereplace = "auto", config_overrides = {} },
      -- Can set this to false to disable main class scan, which is a performance killer for large project
      dap_main = {},
      test = true,
      settings = {
        java = {
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    -- Find the extra bundles that should be passed on the jdtls command-line
    -- if nvim-dap is enabled with java debug/test.
    local bundles = {} ---@type string[]
    local mason_registry = require("mason-registry")

    mason_registry.update()

    local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
    local java_dbg_path = java_dbg_pkg:get_install_path()
    local jar_patterns = {
      java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
    }
    -- java-test also depends on java-debug-adapter.
    if opts.test and mason_registry.is_installed("java-test") then
      local java_test_pkg = mason_registry.get_package("java-test")
      local java_test_path = java_test_pkg:get_install_path()
      vim.list_extend(jar_patterns, {
        java_test_path .. "/extension/server/*.jar",
      })
    end
    for _, jar_pattern in ipairs(jar_patterns) do
      for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
        table.insert(bundles, bundle)
      end
    end

    local function attach_jdtls()

      -- Configuration can be augmented and overridden by opts.jdtls

      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

      local config = {
        cmd = opts.full_cmd(opts),
        root_dir = opts.root_dir,
        init_options = {
          bundles = bundles,
        },
        settings = opts.settings,
        -- enable CMP capabilities
        capabilities = capabilities,
      }

      -- Existing server will be reused if the root_dir matches.
      require("jdtls").start_or_attach(config)
      -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
    end

    -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
    -- depending on filetype, so this autocmd doesn't run for the first file.
    -- For that, we call directly below.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java" },
      callback = attach_jdtls,
    })

    -- Setup keymap and dap after the lsp is fully attached.
    -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
    -- https://neovim.io/doc/user/lsp.html#LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "jdtls" then
            if opts.dap and mason_registry.is_installed("java-debug-adapter") then
              -- custom init for Java debugger
              local jdtls = require("jdtls")
              jdtls.setup_dap(opts.dap)
              vim.keymap.set("n", "<leader>tg", require("jdtls.tests").generate, { buffer = args.buf, desc = "[G]enerate [T]est"})
              vim.keymap.set("n", "<leader>ts", require("jdtls.tests").goto_subjects, { buffer = args.buf, desc = "Go to [S]ubjects of the [T]est"})


              if opts.dap_main then
                require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
              end

              if opts.test and mason_registry.is_installed("java-test") then
                vim.keymap.set( "n", "<leader>tt",
                  function()
                    require("jdtls.dap").test_class({
                      config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
                    })
                  end, { buffer = args.buf, desc = "Run All [T]est" }
                )
                vim.keymap.set( "n", "<leader>tr",
                  function()
                    require("jdtls.dap").test_nearest_method({
                      config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
                    })
                  end, { buffer = args.buf, desc = "[R]un Nearest [T]est" }
                )
                vim.keymap.set( "n", "<leader>tT", require("jdtls.dap").pick_test, { buffer = args.buf, desc = "Run [T]est" } )
            end
          end
        end
      end
    })

    -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
    -- attach_jdtls()
  end,
}
