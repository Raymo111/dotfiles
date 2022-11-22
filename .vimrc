syntax on
command WQ wq
command Wq wq
command W w
command Q q
set clipboard=unnamed
"set clipboard=unnamedplus
set whichwrap+=<,>,h,l,[,]
set shiftwidth=4
set tabstop=4
set number
set laststatus=2
nnoremap <expr> <Down> v:count ? 'j' : 'gj'
nnoremap <expr> <Up> v:count ? 'k' : 'gk'
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
"nnoremap U gUl
"nnoremap u gul
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g`\"" | endif
endif
if has ('nvim')
	set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait100-blinkoff200-blinkon175

	"Reset cursor to Konsole default on leave
	au VimLeave * set guicursor=a:ver25-blinkwait175-blinkon200-blinkoff175

	call plug#begin('~/.vim/plugged')
		"File tree
		Plug 'nvim-tree/nvim-web-devicons' " icons
		Plug 'nvim-tree/nvim-tree.lua'

		"Fuzzy finder
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'

		"Copilot
		Plug 'github/copilot.vim'

		"Syntax highlighting
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

		"Bars
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'ryanoasis/vim-devicons'

		"Scrollbar
		"tbd

		"Discord Rich Presence
		Plug 'andweeb/presence.nvim'
	call plug#end()
endif
