syntax on
filetype plugin indent on
set smartindent
set nu
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" incremental search
set incsearch
" highlight matches
set hlsearch
" left space above and under the cursor
set scrolloff=10
" Use tabs
set autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=4
" Backspace to work
set backspace=indent,eol,start
" Faster scroll
set ttyfast
" Line numbers
set number
set relativenumber
" Leader key
let mapleader = ","
set path=.,**
set colorcolumn=120

" Y copies rest of the line
nnoremap Y y$

" keep cursor in same place when moving between search results
nnoremap n nzzzv
nnoremap N Nzzzv

" Add [""]
nnoremap ," ciw[""]<Esc>p

" Plugins
call plug#begin('~/dotfiles/plugged')
" auto completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'mbbill/undotree'
Plug 'gruvbox-community/gruvbox'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'chrisbra/csv.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'preservim/nerdtree'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-lua/plenary.nvim'
Plug 'leoluz/nvim-dap-go'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'

Plug 'folke/which-key.nvim'
Plug 'easymotion/vim-easymotion'

call plug#end()

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-w>\ :TmuxNavigatePrevious<cr>

let g:vimspector_enable_mappings = 'HUMAN'

set completeopt=menu,menuone,noselect

" Colors
set background=dark " or light if you want light mode
colorscheme gruvbox

" Telescope fuzzy search
nnoremap <leader>e <cmd>Telescope find_files <cr>
nnoremap <leader>g <cmd>Telescope git_files <cr>
nnoremap <leader>w <cmd>Telescope grep_string <cr>
nnoremap ge <cmd>Telescope diagnostics <cr>
nnoremap <leader>\ <cmd>Telescope live_grep <cr>

" Quick fix list moves
nnoremap <C-k> <cmd>cprevious <cr>
nnoremap <C-j> <cmd>cnext <cr>

" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" greatest remap ever
xnoremap <leader>p "_dP

" System clipboard
"set clipboard=unnamed

" Latex compile on save
autocmd BufWritePost *.tex !pdflatex -shell-escape <afile>

" Open NERDtree
nnoremap <Leader>f <cmd>NERDTreeToggle <cr>

" Spell check
set spell spelllang=en_us

" Some servers have issues with backup files, see #649.
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

let g:airline_powerline_fonts = 1

lua <<EOF

  require'nvim-treesitter.configs'.setup {

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete()),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-n>'] = {
                c = function(fallback)
                    local cmp = require('cmp')
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
            },
            ['<C-p>'] = {
                c = function(fallback)
                    local cmp = require('cmp')
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
            },
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
        }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'path' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gpe', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gne', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'pyright', 'gopls', 'clangd', 'bashls', 'ansiblels', 'cmake' }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end

  -- Commenting
  require('Comment').setup()

  local telescope = require('telescope')
  telescope.load_extension('dap')
  telescope.setup {
    pickers = {
      find_files = {
        hidden = true
      }
    }
  }

  local dap = require('dap')
  dap.adapters.dlv_spawn = function(cb)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = {nil, stdout},
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          --- You could adapt this and send `chunk` to somewhere else
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        cb({type = "server", host = "127.0.0.1", port = port})
      end,
      100)
  end
  -- dap.adapters.go = function(callback, config)
  --   local stdout = vim.loop.new_pipe(false)
  --   local handle
  --   local pid_or_err
  --   local port = 38697
  --   local opts = {
  --     stdio = {nil, stdout},
  --     args = {"dap", "-l", "127.0.0.1:" .. port},
  --     detached = true
  --   }
  --   handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
  --     -- stdout:close()
  --     handle:close()
  --     if code ~= 0 then
  --       print('dlv exited with code', code)
  --     end
  --   end)
  --   assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  --   stdout:read_start(function(err, chunk)
  --     assert(not err, err)
  --     if chunk then
  --       vim.schedule(function()
  --         require('dap.repl').append(chunk)
  --       end)
  --     end
  --   end)
  --   -- Wait for delve to start
  --   vim.defer_fn(
  --     function()
  --       callback({type = "server", host = "127.0.0.1", port = port})
  --     end,
  --     100)
  -- end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "dlv_spaw",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}"
    },
    -- works with go.mod packages and sub packages
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}"
    },
    {
			name= "Launch with custom config",
			type= "dlv_spawn",
			request= "launch",
			mode= "debug",
			program= "${workspaceFolder}/main.go",
			cwd= "${workspaceFolder}",
			tags= "dev",
			args= {
				"serve",
				"default_config.yaml",
				"config_2.yaml",
				"../data/20211116_1506/shotmaker.yaml"
			}
    }
  }


  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  -- require('dap-go').setup()


  require("nvim-dap-virtual-text").setup()

  require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      -- You can change the order of elements in the layouts
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        {
          id = "scopes",
          size = 0.25, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 00.25 },
      },
      size = 40,
      position = "left", -- Can be "left", "right", "top", "bottom"
    },
    layouts = {
      elements = { "repl" },
      ize = 10,
      position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  })
  local root = vim.fn.finddir('.git/..', ';')
  require('dap.ext.vscode').load_launchjs(root .. '/.vim/launch.json') -- parse .vim/launch.json if exists
  -- require('dap.ext.vscode').load_launchjs(root .. '/.vscode/launch.json') -- parse .vim/launch.json if exists

EOF
