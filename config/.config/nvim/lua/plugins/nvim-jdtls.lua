return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()

    local function attach_jdtls()

      local root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"})
      if not root_dir then
        vim.notify("jdtls: could not find project root", vim.log.levels.ERROR)
        return
      end

      local project_name = vim.fn.fnamemodify(root_dir, ":t")

      local mason_share = vim.fn.expand("$MASON/share")
      local mason_packages = vim.fn.expand("$MASON/packages")

      local os_name = vim.loop.os_uname().sysname
      local config_path
      if os_name == "Darwin" then
        config_path = mason_packages .. "/jdtls/config_mac"
      elseif os_name == "Linux" then
        config_path = mason_packages .. "/jdtls/config_linux"
      else
        config_path = mason_packages .. "/jdtls/config_win"
      end

      local java_exec = vim.fn.expand("$HOME/.sdkman/candidates/java/24.0.2-open/bin/java")

      local lombok_jar = mason_share .. "/jdtls/lombok.jar"

      local equinox_launcher_jar = vim.fn.glob(mason_share .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"


      local bundles = {} ---@type string[]
      local java_dbg_jars_pattern = mason_share .. "/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar"
      local java_test_jars_pattern = mason_share .. "/java-test/*.jar"
      for _, jar_pattern in ipairs({ java_dbg_jars_pattern, java_test_jars_pattern }) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
          table.insert(bundles, bundle)
        end
      end





      local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {

          java_exec,
          '-javaagent:' .. lombok_jar,
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

          '-jar', equinox_launcher_jar,
          '-configuration', config_path,
          '-data', workspace_dir
        },

        root_dir = root_dir,

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk/",
                },
                {
                  name = "JavaSE-17",
                  path = "/usr/lib/jvm/java-17-openjdk/",
                },
                {
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-openjdk/",
                },
                {
                  name = "JavaSE-24",
                  path = "/usr/lib/jvm/java-24-openjdk/",
                },
              }
            }
          }
        },

        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
        init_options = {
          bundles = bundles
        },
      }
      -- This starts a new client & server,
      -- or attaches to an existing client & server depending on the `root_dir`.

      if not vim.loop.fs_stat(workspace_dir) then
        vim.fn.mkdir(workspace_dir, "p")
      end


      -- Existing server will be reused if the root_dir matches.
      require("jdtls").start_or_attach(config)
      -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java" },
      callback = attach_jdtls,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "jdtls" then
            -- custom init for Java debugger
            local jdtls = require("jdtls")
            jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
            vim.keymap.set("n", "<leader>tg", require("jdtls.tests").generate, { buffer = args.buf, desc = "[G]enerate [T]est"})
            vim.keymap.set("n", "<leader>ts", require("jdtls.tests").goto_subjects, { buffer = args.buf, desc = "Go to [S]ubjects of the [T]est"})


            -- require("jdtls.dap").setup_dap_main_class_configs()

            vim.keymap.set( "n", "<leader>tt",
              function()
                require("jdtls.dap").test_class()
              end, { buffer = args.buf, desc = "Run All [T]est" }
            )

            vim.keymap.set( "n", "<leader>tr",
              function()
                require("jdtls.dap").test_nearest_method()
              end, { buffer = args.buf, desc = "[R]un Nearest [T]est" }
            )
            vim.keymap.set( "n", "<leader>tT", require("jdtls.dap").pick_test, { buffer = args.buf, desc = "Run [T]est" } )
        end
      end
    })

  end,
}
