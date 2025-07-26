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
  -- {
  --   {
  --     "nvim-java/nvim-java",
  --     dependencies = {
  --       "nvim-java/lua-async-await",
  --       "nvim-java/nvim-java-core",
  --       "nvim-java/nvim-java-test",
  --       "nvim-java/nvim-java-dap",
  --       "nvim-java/nvim-java-refactor",
  --     },
  --     config = function()
  --       require("java").setup()
  --     end,
  --     ft = { "java" }, -- Only load for Java files
  --   },
  -- },
  {
    {
      "mfussenegger/nvim-jdtls",
      ft = { "java" },
      config = function()
        local jdtls = require("jdtls")
  
        local home = os.getenv("HOME")
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
        local root_dir = require("jdtls.setup").find_root(root_markers)
        if not root_dir then return end
  
        local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_dir = home .. "/.local/share/eclipse/" .. project_name
  
        local config = {
          cmd = {
            vim.fn.stdpath("data") .. "/mason/bin/jdtls",
            "-data", workspace_dir,
          },
          root_dir = root_dir,
          settings = {
            java = {
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-21",
                    path = "/Users/mtiwar006@cable.comcast.com/.sdkman/candidates/java/current/bin/java",
                  },
                },
              },
            },
          },
          init_options = {
            bundles = {},
          },
          on_attach = function(client, bufnr)
            jdtls.setup_dap({ hotcodereplace = "auto" })
            jdtls.dap.setup_dap_main_class_configs()
            jdtls.setup.add_commands()
          end,
        }
  
        jdtls.start_or_attach(config)
      end,
    },
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
    "romgrk/barbar.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- patched fonts support 
        "lewis6991/gitsigns.nvim" -- display git status
    },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
        local barbar = require("barbar")

        barbar.setup({
            clickable = true, -- Enables/disables clickable tabs
            tabpages = false, -- Enable/disables current/total tabpages indicator (top right corner)
            insert_at_end = true,
            icons = {
                button = "",
                buffer_index = true,
                filetype = {enabled = true},
                visible = {modified = {buffer_number = false}},
                gitsigns = {
                    added = {enabled = true, icon = "+"},
                    changed = {enabled = true, icon = "~"},
                    deleted = {enabled = true, icon = "-"}
                }
            }
        })

        -- key maps

        local map = vim.api.nvim_set_keymap
        local opts = {noremap = true, silent = true}

        -- Move to previous/next
        map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
        map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
        -- Re-order to previous/next
        map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
        map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
        -- Goto buffer in position...
        map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
        map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
        map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
        map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
        map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
        map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
        map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
        map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
        map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
        map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
        -- Pin/unpin buffer
        map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
        -- Close buffer
        map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
        map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "v1.7.0",
    enabled = true,
    priority = 1000,
    config = function()
        vim.opt.termguicolors = true

        local catppuccin = require("catppuccin")

        catppuccin.setup({
            flavour = "mocha",
            term_colors = true,
            styles = {
                conditionals = {},
                functions = {"italic"},
                types = {"bold"}
            },
            color_overrides = {
                mocha = {
                    base = "#171717", -- background
                    surface2 = "#9A9A9A", -- comments
                    text = "#F6F6F6"
                }
            },
            highlight_overrides = {
                mocha = function(C)
                    return {
                        NvimTreeNormal = {bg = C.none},
                        CmpBorder = {fg = C.surface2},
                        Pmenu = {bg = C.none},
                        NormalFloat = {bg = C.none},
                        TelescopeBorder = {link = "FloatBorder"}
                    }
                end
            },
            integrations = {
                barbar = true,
                cmp = true,
                gitsigns = true,
                native_lsp = {enabled = true},
                nvimtree = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true
            }
        })

        vim.cmd.colorscheme("catppuccin")
    end
 },
  {
    "rhysd/vim-clang-format",
    init = function()
        vim.cmd([[
autocmd FileType proto ClangFormatAutoEnable
]])
    end
 },
{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- cmp_nvim_lsp
        "neovim/nvim-lspconfig", -- lspconfig
        "onsails/lspkind-nvim", -- lspkind (VS pictograms)
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {"rafamadriz/friendly-snippets"}, -- Snippets
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                -- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
            end
        }, {"saadparwaiz1/cmp_luasnip", enabled = true}
    },
    config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")

        -- Display virtual text to indicate snippet has more nodes
        luasnip.config.setup({
            ext_opts = {
                [types.choiceNode] = {
                    active = {virt_text = {{"⇥", "GruvboxRed"}}}
                },
                [types.insertNode] = {
                    active = {virt_text = {{"⇥", "GruvboxBlue"}}}
                }
            }
        })

        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            }),
            sources = cmp.config.sources({
                {name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 70,
                    show_labelDetails = true
                })
            }
        })

        local lspconfig = require("lspconfig")

        -- All languages: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

        -- Default lspconfig values for Go are set by `navigator`
        -- Go: go install golang.org/x/tools/gopls@latest

        -- Python: brew install pyright
        lspconfig["pyright"].setup {}

        -- Ruby: gem install solargraph
        lspconfig["solargraph"].setup {}

        -- https://phpactor.readthedocs.io/en/master/usage/standalone.html#installation
        lspconfig["phpactor"].setup {}
    end
 },
 {
    "numToStr/Comment.nvim",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function() require("Comment").setup() end
 },
 {"chrisbra/csv.vim", enabled = true},
 {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons", "catppuccin/nvim"},
    config = function()
        require("lualine").setup({options = {theme = "catppuccin"}})
    end
 }, 
 {
    "ray-x/navigator.lua",
    dependencies = {
        {"hrsh7th/nvim-cmp"}, {"nvim-treesitter/nvim-treesitter"},
        {"ray-x/guihua.lua", run = "cd lua/fzy && make"}, {
            "ray-x/go.nvim",
            event = {"CmdlineEnter"},
            ft = {"go", "gomod"},
            build = ':lua require("go.install").update_all_sync()'
        }, {
            "ray-x/lsp_signature.nvim", -- Show function signature when you type
            event = "VeryLazy",
            config = function() require("lsp_signature").setup() end
        }
    },
    config = function()
        require("go").setup()
        require("navigator").setup({
            lsp_signature_help = true, -- enable ray-x/lsp_signature
            lsp = {format_on_save = true}
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"go"},
            callback = function(ev)
                -- CTRL/control keymaps
                vim.api
                    .nvim_buf_set_keymap(0, "n", "<C-i>", ":GoImport<CR>", {})
                vim.api.nvim_buf_set_keymap(0, "n", "<C-b>", ":GoBuild %:h<CR>",
                                            {})
                vim.api.nvim_buf_set_keymap(0, "n", "<C-t>", ":GoTestPkg<CR>",
                                            {})
                vim.api.nvim_buf_set_keymap(0, "n", "<C-c>",
                                            ":GoCoverage -p<CR>", {})

                -- Opens test files
                vim.api.nvim_buf_set_keymap(0, "n", "A",
                                            ":lua require('go.alternate').switch(true, '')<CR>",
                                            {}) -- Test
                vim.api.nvim_buf_set_keymap(0, "n", "V",
                                            ":lua require('go.alternate').switch(true, 'vsplit')<CR>",
                                            {}) -- Test Vertical
                vim.api.nvim_buf_set_keymap(0, "n", "S",
                                            ":lua require('go.alternate').switch(true, 'split')<CR>",
                                            {}) -- Test Split
            end,
            group = vim.api.nvim_create_augroup("go_autocommands",
                                                {clear = true})
        })
    end
 },
 {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    build = ":TSUpdate",
    dependencies = {
        {"nvim-treesitter/nvim-treesitter-textobjects"}, -- Syntax aware text-objects
        {
            "nvim-treesitter/nvim-treesitter-context", -- Show code context
            opts = {enable = true, mode = "topline", line_numbers = true}
        }
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"markdown"},
            callback = function(ev)
                -- treesitter-context is buggy with Markdown files
                require("treesitter-context").disable()
            end
        })

        treesitter.setup({
            ensure_installed = {
                "csv", "dockerfile", "gitignore", "go", "gomod", "gosum",
                "gowork", "javascript", "json", "lua", "markdown", "proto",
                "python", "rego", "ruby", "sql", "svelte", "yaml", "php"
            },
            indent = {enable = true},
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                disable = {"csv"} -- preferring chrisbra/csv.vim
            },
            textobjects = {select = {enable = true, lookahead = true}}
        })
    end
 }, 
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft = { "go", "gomod" },
    config = function()
      require("go").setup({
        lsp_cfg = true, -- auto-configure gopls
        lsp_on_attach = true,
        dap_debug = true,
      })
    end,
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
    -- version = "1.10.0", -- or any version before 2.0
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
