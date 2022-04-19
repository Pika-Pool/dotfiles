"         
" ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
" ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
" ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
" ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"

" use 24-bit(true-color) mode
if(empty($TMUX))
  if(has("nvim"))
    " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  " For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  if(has("termguicolors"))
    set termguicolors
  endif
endif

call plug#begin()
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" lsp extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Find, Filter, Preview, Pick files
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" file explorer
Plug 'kyazdani42/nvim-tree.lua'

" status line
Plug 'nvim-lualine/lualine.nvim'

" buffer line, i.e., tabs list
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" for jsx
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Comment shortcuts
Plug 'tpope/vim-commentary'

" onedark color scheme
Plug 'joshdick/onedark.vim'

" highlight colors in file(visualise hex colors like in vscode)
Plug 'norcalli/nvim-colorizer.lua'

" git status in gutter
Plug 'airblade/vim-gitgutter'
call plug#end()

source "./coc_config.vim"

" colorscheme settings:
" onedark.vim settings
let g:onedark_hide_endofbuffer=0
let g:onedark_terminal_italics=1                                                                                                                              

" Enabling filetype support provides filetype-specific indenting,
" synatx highligting, omni-completion and other useful settings
filetype plugin indent on
syntax on
colorscheme onedark

lua require'colorizer'.setup()

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
