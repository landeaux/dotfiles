local on_attach = function(client, bufnr)
  require('completion').on_attach()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

end

local nvim_lsp = require('lspconfig')

nvim_lsp.cssls.setup { on_attach = on_attach }

nvim_lsp.html.setup { on_attach = on_attach }

nvim_lsp.tsserver.setup { on_attach = on_attach }

local sumneko_root_path = vim.fn.stdpath('data') .. '/lspinstall/lua'
local sumneko_binary = sumneko_root_path .. '/sumneko-lua-language-server'

nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary },
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim', 'use' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        },
        maxPreload = 10000
      }
    }
  }
}

-- Setup diagnostics formaters and linters for non LSP provided files
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    cmd = {"diagnostic-languageserver", "--stdio"},
    filetypes = {
      'javascript'
    },
    init_options = {
        linters = {
          eslint = {
            command = './node_modules/.bin/eslint',
            rootPatterns = {'.git'},
            debounce = 100,
            args = {
              '--stdin',
              '--stdin-filename',
              '%filepath',
              '--format',
              'json'
            },
            sourceName = 'eslint',
            parseJson = {
              errorsRoot = '[0].messages',
              line = 'line',
              column = 'column',
              endLine = 'endLine',
              endColumn = 'endColumn',
              message = '${message} [${ruleId}]',
              security = 'severity'
            },
            securities = {
              [2] = 'error',
              [1] = 'warning',
            },
          },
        },
        filetypes = {
          javascript = 'eslint'
        },
        -- formatters = {
        --     shfmt = {
        --         command = "shfmt",
        --         args = {"-i", "2", "-bn", "-ci", "-sr"}
        --     },
        --     prettier = {
        --         command = "prettier",
        --         args = {"--stdin-filepath", "%filepath"},
        --     }
        -- },
        -- formatFiletypes = {
        --     sh = "shfmt",
        --     json = "prettier",
        --     yaml = "prettier",
        --     toml = "prettier",
        --     markdown = "prettier",
        --     lua = "prettier"
        -- }
    }
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = true
    }
)

