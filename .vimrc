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
inoremap <M-C-H> <C-W>
nnoremap <M-C-H> db
inoremap <C-Del> <C-o>de
nnoremap <C-Del> de

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

	"presence.nvim config
	" General options
	let g:presence_auto_update         = 1
	let g:presence_neovim_image_text   = "Neovim on Arch Linux"
	let g:presence_main_image          = "neovim"
	let g:presence_client_id           = "793271441293967371"
	let g:presence_debounce_timeout    = 10
	let g:presence_enable_line_number  = 0
	let g:presence_blacklist           = []
	let g:presence_buttons             = 1
	let g:presence_file_assets         = {}
	let g:presence_show_time           = 1

	" Rich Presence text options
	let g:presence_editing_text        = "Editing %s"
	let g:presence_file_explorer_text  = "Browsing %s"
	let g:presence_git_commit_text     = "Committing changes"
	let g:presence_plugin_manager_text = "Managing plugins"
	let g:presence_reading_text        = "Reading %s"
	let g:presence_workspace_text      = "Working on %s"
	let g:presence_line_number_text    = "Line %s out of %s"
lua << EOF
	-- disable netrw at the very start of your init.lua (strongly advised)
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- set termguicolors to enable highlight groups
	vim.opt.termguicolors = true

	-- empty setup using defaults
	require("nvim-tree").setup()
EOF
endif
