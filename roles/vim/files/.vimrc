"------------------------------------------------------------
" Plugins
"------------------------------------------------------------
call plug#begin()

" Usefull utils
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Styles
Plug 'mhartington/oceanic-next'

" Syntax check
Plug 'vim-syntastic/syntastic'

" Terraform plugins
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

" Python
Plug 'davidhalter/jedi-vim'
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'mustache/vim-mustache-handlebars'
Plug 'nvie/vim-flake8'

" Yaml
Plug 'stephpy/vim-yaml'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Other
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'myhere/vim-nodejs-complete'
Plug 'rodjek/vim-puppet'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

call plug#end()

"------------------------------------------------------------
" General from Fatih-Go
"------------------------------------------------------------
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2             " Indicate terminal type for mouse codes
set ttyscroll=3                 " Speedup scrolling
" set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start  " Makes backspace key more powerful.

set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
" set splitright                  " Vertical windows should be split to right
" set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.

" 'hidden' option - allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden                      " Buffer should still exist if window is closed

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
" set noshowmatch                 " Do not show matching brackets by flickering
" set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

"------------------------------------------------------------
" My Configs
"------------------------------------------------------------
colorscheme OceanicNext
set autowriteall
set wildmenu

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" set leader to ,
let mapleader = ','

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

set cursorline
hi cursorline term=bold cterm=bold  guibg=Grey40

set scrolloff=10
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" copy paste between terminals
autocmd BufWritePre * %s/\s\+$//e

" yaml syntax for *.jinja files
au BufNewFile,BufRead *.jinja set filetype=yaml
au BufNewFile,BufRead *.yml set filetype=yaml

" go html templates
au BufNewFile,BufRead *.tmpl setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" toogle paste mode
set pastetoggle=<F2>

"------------------------------------------------------------
" Golang Configs
"------------------------------------------------------------
" advanced syntax highligh
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" keyboard shortcuts
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>i  <Plug>(go-import)
autocmd FileType go nmap <leader>d <Plug>(go-doc)
autocmd FileType go nmap <leader>a <Plug>(go-alternate)
autocmd FileType go nmap gr <Plug>(go-rename)

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>c :cclose<CR>
let g:go_list_type = "quickfix"

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

"------------------------------------------------------------
" Autocompletion + snippets
"------------------------------------------------------------
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-m>', '<Up>']
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
set completeopt-=preview


"------------------------------------------------------------
" Python
"------------------------------------------------------------
" virtualenv support
" python3 << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF


"------------------------------------------------------------
" Syntatic-syntax
"------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['python3']


"------------------------------------------------------------
" Shell-checks
"------------------------------------------------------------
let g:syntastic_sh_shellcheck_args="-e SC1091"


"------------------------------------------------------------
" Terraform
"------------------------------------------------------------
" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0
autocmd BufWritePre *.tf :TerraformFmt
