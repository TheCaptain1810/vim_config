" -----------------------------------
" General Settings
" -----------------------------------
set number                " Show line numbers
set relativenumber        " Relative line numbers
set tabstop=4             " Number of spaces for a tab
set shiftwidth=4          " Number of spaces for indentation
set expandtab             " Use spaces instead of tabs
set autoindent            " Copy indent from the current line
set smartindent           " Smart auto-indentation
set wrap                  " Enable line wrapping
set clipboard=unnamedplus " Use system clipboard
set mouse=a               " Enable mouse support
set ignorecase            " Ignore case in searches
set smartcase             " Case-sensitive search when uppercase is used
set splitbelow            " Horizontal splits go below
set splitright            " Vertical splits go to the right
set scrolloff=8           " Keep 8 lines visible around the cursor
set termguicolors         " Enable 24-bit RGB colors
set background=dark       " Dark theme
set timeoutlen=500        " Faster key mappings
set undofile              " Persistent undo
set hidden                " Allow unsaved buffers to stay open

" -----------------------------------
" Key Mappings
" -----------------------------------
nnoremap <Space> <NOP>       " Disable default space behavior
let mapleader = " "          " Set space as leader key

" Save and exit shortcuts
nnoremap <leader>w :w<CR>    " Save file
nnoremap <leader>q :q<CR>    " Quit Neovim
nnoremap <leader>x :x<CR>    " Save and quit

" Toggle NvimTree
nnoremap <C-n> :NvimTreeToggle<CR>

" Clear search highlights
nnoremap <leader>n :noh<CR>

" Open Telescope search
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" Window navigation shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Resize splits with arrows
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Quickly exit insert mode with jj
inoremap jj <Esc>           " Escape insert mode with 'jj'

" -----------------------------------
" Plugin Manager (vim-plug)
" -----------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" Core Plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" File Explorer
Plug 'kyazdani42/nvim-tree.lua'

" Status Line
Plug 'nvim-lualine/lualine.nvim'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Telescope (Fuzzy Finder)
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Theme
Plug 'gruvbox-community/gruvbox'

" Code Formatting
Plug 'prettier/vim-prettier', {'do': 'npm install'}

" Commentary
Plug 'tpope/vim-commentary'

call plug#end()

" -----------------------------------
" Treesitter Configuration
" -----------------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "javascript", "html", "css", "bash" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
EOF

" -----------------------------------
" LSP Configuration
" -----------------------------------
lua << EOF
-- LSP Configuration
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- Setup LSP servers
lspconfig['ts_ls'].setup{on_attach = on_attach, capabilities = capabilities}
lspconfig['pyright'].setup{on_attach = on_attach, capabilities = capabilities}

EOF

" -----------------------------------
" Completion Configuration
" -----------------------------------
"lua << EOF
"-- Completion Configuration
"vim.cmd [[packadd nvim-cmp]]  -- Ensure the plugin is loaded
"
"local cmp = require'cmp'
"cmp.setup({
"  snippet = {
"    expand = function(args)
"      require'luasnip'.lsp_expand(args.body)
"    end,
"  },
"  mapping = {
"    ['<C-n>'] = cmp.mapping.select_next_item(),
"    ['<C-p>'] = cmp.mapping.select_prev_item(),
"    ['<C-Space>'] = cmp.mapping.complete(),
"    ['<C-e>'] = cmp.mapping.close(),
"    ['<CR>'] = cmp.mapping.confirm({ select = true }),
"  },
"  sources = cmp.config.sources({
"    { name = 'nvim_lsp' },
"    { name = 'luasnip' },
"  }, {
"    { name = 'buffer' },
"  }),
"})
"EOF

" -----------------------------------
" Telescope Configuration
" -----------------------------------
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", "%.git/"},
  }
}
EOF

" -----------------------------------
" NvimTree Configuration
" -----------------------------------
lua << EOF
require'nvim-tree'.setup {
  view = {
    width = 30,
  },
  renderer = {
    icons = {
      show = {
        folder = true,
        file = true,
      },
    },
  },
}
EOF

" -----------------------------------
" Lualine Configuration
" -----------------------------------
lua << EOF
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    section_separators = '',
    component_separators = '',
  }
}
EOF

" -----------------------------------
" Appearance
" -----------------------------------
colorscheme gruvbox      " Gruvbox theme
set background=dark

