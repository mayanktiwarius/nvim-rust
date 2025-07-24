return {
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        config = function()
          require("diffview").setup({})
        end
      }
    }
  },
  {
      "LunarVim/bigfile.nvim",
      config = function()
          require("bigfile").setup({
              filesize = 2, -- Size in MiB (default)
              pattern = { "*" },
              features = {  -- features to disable for big files
                  "indent_blankline",
                  "illuminate",
                  "lsp",
                  "treesitter",
                  "syntax",
                  "matchparen",
                  "vimopts",
                  "filetype",
              }
          })
      end
  },
  {
      'linux-cultist/venv-selector.nvim',
      event = 'VeryLazy',
      dependencies = {
          'neovim/nvim-lspconfig',
          'nvim-telescope/telescope.nvim',
          'mfussenegger/nvim-dap-python',
      },
      branch = "regexp",
      config = function()
          local function shorter_name(filename)
              return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
          end
          require('venv-selector').setup {
              options = { on_telescope_result_callback = shorter_name },
              name = { ".venv" },
              auto_refresh = false
          }
      end,
      
  },
  {
      "OXY2DEV/markview.nvim",
      lazy = false,
      priority = 49,
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons",
      }
  },
  {
      {
          "lewis6991/gitsigns.nvim",
          config = function()
              require("gitsigns").setup({
                  current_line_blame = true,
                  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
              })
          end
      },
      {
          "tpope/vim-fugitive",
      }
  },
  {
      "kylechui/nvim-surround",
      version = "^3.1.1",
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({})
      end
  },
  {
      "godlygeek/tabular",
      event = "VeryLazy", -- Load the plugin lazily
  },
  {
  	"folke/todo-comments.nvim",
  	dependencies = { "nvim-lua/plenary.nvim" },
  	config = function()
  		require("todo-comments").setup({
  			keywords = {
  				BUG = { icon = " ", color = "error", alt = { "FIXME", "bug" } },
  				FEATURE = { icon = " ", color = "feature", alt = { "feature" } },
  				INFO = { icon = " ", color = "info", alt = { "info" } },
  				TODO = { icon = " ", color = "todo", alt = { "todo" } },
  				FIXME = { icon = " ", color = "fix", alt = { "fixme" } },
  				FUTURE = { icon = " ", color = "future", alt = { "future" } },
  				DEBUG = { icon = " ", color = "debug", alt = { "debug" } },
  				DELETE = { icon = " ", color = "delete", alt = { "delete" } },
  				ATTENTION = { icon = " ", color = "attention", alt = { "attention" } },
  				PROBLEM = { icon = " ", color = "problem", alt = { "problem" } },
  				SOLUTION = { icon = " ", color = "solution", alt = { "solution" } },
  				COMMAND = { icon = " ", color = "command", alt = { "command" } },
  				CHECKED = { icon = " ", color = "checked", alt = { "checked" } },
  				ISSUE = { icon = " ", color = "issue", alt = { "issue" } },
  				EXPLAIN = { icon = " ", color = "explain", alt = { "explain" } },
  			},
  			colors = {
  				error = { "#ff0544" },
  				feature = { "#35ff11" },
  				info = { "#6a9918" },
  				todo = { "#388aa6" },
  				fix = { "#ca3ecf" },
  				future = { "#003050" },
  				debug = { "#B73A3A" },
  				delete = { "#ff6342" },
  				attention = { "#f576ee" },
  				problem = { "#f74545" },
  				solution = { "#02ed1a" },
  				command = { "#00f7ca" },
  				checked = { "#a7f757" },
  				issue = { "#ba0262" },
  				explain = { "#A0E7E5" },
  			},
  			search = {
  				command = "rg",
  				args = {
  					"--color=never",
  					"--no-heading",
  					"--with-filename",
  					"--line-number",
  					"--column",
  					"--ignore-case",
  				},
  				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
  			},
  		})
  	end,
  },
  {
  	'akinsho/bufferline.nvim',
  	event = "VeryLazy",
  	dependencies = {
  			'nvim-tree/nvim-web-devicons'
  	},
  
  	config = function()
  			require('bufferline').setup({
  					options = {
  							always_show_bufferline = true,
  							diagnostics = "nvim_lsp",
  							diagnostics_indicator = function(count, level, diagnostics_dict, context)
  									local s = { error = " ", warn = " ", info = " ", hint = " " }
  									local icon = ""
  									if level == vim.diagnostic.severity.ERROR then
  											icon = s.error
  									elseif level == vim.diagnostic.severity.WARN then
  											icon = s.warn
  									elseif level == vim.diagnostic.severity.INFO then
  											icon = s.info
  									elseif level == vim.diagnostic.severity.HINT then
  											icon = s.hint
  									end
  									return count > 0 and (icon .. count) or ""
  							end,
  							offsets = {
  									{
  											filetype = "neo-tree",
  											text = "Explorer",
  											text_align = "left",
  											separator = true
  									}
  							},
  					}
  			})
  	end,
  },
  -- {
  --   'sindrets/diffview.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     require("diffview").setup({})
  --   end
  -- },
  {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
          "MunifTanjim/nui.nvim",
          "rcarriga/nvim-notify",
          -- "nvim-treesiter/nvim-treesiter",
          "nvim-treesitter/nvim-treesitter",
      },
      config = function()
          require("noice").setup({
              lsp = {
                  override = {
                      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                      ["vim.lsp.util.stylize_markdown"] = true,
                      -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                  },
              },
              presets = {
                  bottom_search = false,
                  command_palette = false,
                  long_message_to_split = true,
                  inc_rename = false,
                  lsp_doc_border = false,
              },
          })
      end
  },
  {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
          vim.o.foldcolumn = '0'    -- '1' if you want to have extra column for fold info
          vim.o.foldlevel = 99
          vim.o.foldlevelstart = 15 -- high value for dashboard, top 30 level folds are open, anything beyond that is closed
          vim.o.foldenable = true
          -- vim.o.foldnestmax = 5     -- no fold for more than 5 level of nesting
  
          local ftMap = {
              vim = 'indent',
              python = { 'lsp', 'indent' },
              rust = { 'lsp', 'indent' },
              lua = { 'lsp', 'indent' },
              git = '',
          }
  
          local function customizeSelector(bufnr)
              local function handleFallbackException(err, providerName)
                  if type(err) == 'string' and err:match('UfoFallbackException') then
                      return require('ufo').getFolds(bufnr, providerName)
                  else
                      return require('promise').reject(err)
                  end
              end
  
              return require('ufo')
                  .getFolds(bufnr, 'lsp')
                  :catch(function(err)
                      return handleFallbackException(err, 'treesitter')
                  end)
                  :catch(function(err)
                      return handleFallbackException(err, 'indent')
                  end)
          end
  
          local handler = function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = (' 󰁂 %d '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0
              for _, chunk in ipairs(virtText) do
                  local chunkText = chunk[1]
                  local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  if targetWidth > curWidth + chunkWidth then
                      table.insert(newVirtText, chunk)
                  else
                      chunkText = truncate(chunkText, targetWidth - curWidth)
                      local hlGroup = chunk[2]
                      table.insert(newVirtText, { chunkText, hlGroup })
                      chunkWidth = vim.fn.strdisplaywidth(chunkText)
                      if curWidth + chunkWidth < targetWidth then
                          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                      end
                      break
                  end
                  curWidth = curWidth + chunkWidth
              end
              table.insert(newVirtText, { suffix, 'MoreMsg' })
              return newVirtText
          end
  
          -- Setup nvim-ufo
          require('ufo').setup({
              provider_selector = function(_, filetype, _)
                  return ftMap[filetype] or customizeSelector
              end,
              fold_virt_text_handler = handler,
          })
      end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    config = function()
      require("mason").setup()
      -- Notify user about required tools
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
          vim.schedule(function()
            local mr = require("mason-registry")
            local required_tools = {"rust-analyzer", "codelldb"}
            local missing_tools = {}
            
            for _, tool in ipairs(required_tools) do
              if not mr.is_installed(tool) then
                table.insert(missing_tools, tool)
              end
            end
            
            if #missing_tools > 0 then
              vim.notify(
                "Some required tools are not installed. Please run:\n" ..
                ":MasonInstall " .. table.concat(missing_tools, " "),
                vim.log.levels.WARN
              )
            end
          end)
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "rust_analyzer",
      },
      automatic_installation = true,
    },
  },

  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = 'v6.3.1',
    lazy = false,
    ft = "rust",
    config = function()
      vim.g.rustaceanvim = {
        -- Server settings
        server = {
          on_attach = function(client, bufnr)
            -- Enable inlay hints
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            
            -- Enable format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end,
          settings = {
            -- Enable rustfmt on save
            ['rust-analyzer'] = {
              checkOnSave = true,
              -- Automatic format on save
              format = {
                enable = true,
              },
            },
          },
        },
        -- Tools settings
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
      }

      -- Set up format on save
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0

      -- Set up DAP if codelldb is available
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
          vim.schedule(function()
            local mr = require("mason-registry")
            if not mr.is_installed("codelldb") then
              vim.notify("Rustaceanvim: 'codelldb' is not installed via Mason. Please install it using :MasonInstall codelldb for Rust debugging.", vim.log.levels.WARN)
            else
              -- Get package details into a distinct variable
              local codelldb_pkg = mr.get_package("codelldb")
              if not codelldb_pkg then
                vim.notify("Rustaceanvim: 'codelldb' is installed but Mason could not provide package details. Rust DAP setup skipped. You might need to run :MasonUpdate or check Mason's health.", vim.log.levels.WARN)
              else
                -- Now it's safe to use codelldb_pkg
                local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
                -- vim.notify("Rustaceanvim DAP: CodeLLDB extension path: " .. extension_path, vim.log.levels.INFO)
                -- vim.notify("Rustaceanvim DAP: CodeLLDB adapter path: " .. codelldb_path, vim.log.levels.INFO)
                -- vim.notify("Rustaceanvim DAP: CodeLLDB library path: " .. liblldb_path, vim.log.levels.INFO)
                local cfg_rustacean = require('rustaceanvim.config')
                if not cfg_rustacean or type(cfg_rustacean.get_codelldb_adapter) ~= "function" then
                  vim.notify("Rustaceanvim: Error loading rustaceanvim.config or get_codelldb_adapter function missing. DAP setup skipped.", vim.log.levels.ERROR)
                else
                  vim.g.rustaceanvim = vim.tbl_deep_extend("force", vim.g.rustaceanvim, {
                    dap = {
                      adapter = cfg_rustacean.get_codelldb_adapter(codelldb_path, liblldb_path),
                    },
                  })
                  -- vim.notify("Rustaceanvim: Successfully configured DAP for codelldb.", vim.log.levels.INFO) -- Added success notification
                end
              end
            end
          end)
        end,
      })
    end
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui', 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end,
  },

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      -- cmp.setup.buffer call removed
    end
  },
  { import = "custom.configs.cmp" },
  -- Python LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({})
    end,
  },
  
  -- Formatters and Linters
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.flake8,
        },
      })
    end,
  },
  
  -- Debugging
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
  },
  
  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-python" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({ dap = { justMyCode = false } }),
        },
      })
    end,
  }
}
