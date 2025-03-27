return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim"
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "[D]ebug: Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "[D]ebug: Toggle Breakpoint" },
      { "<F1>", function() require("dap").continue() end, desc = "Debug: Run/Continue" },
      { "<F2>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F3>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F4>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<F5>", function() require("dap").step_back() end, desc = "Debug: Step Back" },
      { "<F6>", function() require("dap").restart() end, desc = "Debug: Restart" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "[D]ebug: Run with [A]rgs" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "[D]ebug: Run to [C]ursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "[D]ebug: [G]o to Line (No Execute)" },
      { "<leader>dj", function() require("dap").down() end, desc = "[D]ebug: Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "[D]ebug: Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "[D]ebug: Run [L]ast" },
      { "<leader>dP", function() require("dap").pause() end, desc = "[D]ebug: [P]ause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "[D]ebug: Toggle [R]EPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "[D]ebug: [S]ession" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "[D]ebug: [T]erminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "[D]ebug: [W]idgets" },
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "[D]ebug: Dap [U]I" },
      { "<leader>de", function() require("dapui").eval() end, desc = "[D]ebug: [E]val", mode = {"n", "v"} },
    },
    config = function ()
      local dap = require("dap")
      local ui = require("dapui")

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })


      local path = require "mason-core.path"
      dap.adapters.codelldb = {
        type = 'executable',
        command = path.concat { vim.fn.stdpath "data", "mason/packages/codelldb/codelldb" }, -- adjust as needed, must be absolute path
        name = 'codelldb'
      }


      dap.adapters.java = function(callback)
        -- FIXME:
        -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
        -- The response to the command must be the `port` used below
        callback({
          type = 'server';
          host = '127.0.0.1';
          port = 5005;
        })
      end

      dap.configurations.java = {
        {
          type = 'java';
          request = 'attach';
          name = "Debug (Attach) - Remote";
          hostName = "127.0.0.1";
          port = 5005;
        },
      }

      dap.configurations.c = {
          {
              type = 'codelldb',
              request = 'launch',
              program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
              end,
              --program = '${fileDirname}/${fileBasenameNoExtension}',
              cwd = '${workspaceFolder}',
              terminal = 'integrated'
          }
      }

      dap.configurations.cpp = dap.configurations.c

      dap.configurations.rust = {
          {
              type = 'codelldb',
              request = 'launch',
              program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
              end,
              cwd = '${workspaceFolder}',
              terminal = 'integrated',
              sourceLanguages = { 'rust' }
          }
      }

      dap.configurations.kotlin = {
          {
              type = "kotlin",
              request = "launch",
              name = "This file",
              -- may differ, when in doubt, whatever your project structure may be,
              -- it has to correspond to the class file located at `build/classes/`
              -- and of course you have to build before you debug
              mainClass = function()
                  local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
                  local fname = vim.api.nvim_buf_get_name(0)
                  -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
                  return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
              end,
              projectRoot = "${workspaceFolder}",
              jsonLogFile = "",
              enableJsonLogging = false,
          },
          {
              -- Use this for unit tests
              -- First, run 
              -- ./gradlew --info cleanTest test --debug-jvm
              -- then attach the debugger to it
              type = "kotlin",
              request = "attach",
              name = "Attach to debugging session",
              port = 5005,
              args = {},
              projectRoot = vim.fn.getcwd,
              hostName = "localhost",
              timeout = 2000,
          },

      }

      ui.setup()
      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end


    end
  }
}
