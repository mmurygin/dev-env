"------------------------------------------------------------
" Plugins
"------------------------------------------------------------
call plug#begin()

" Usefull utils
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'            " gcc to comment line, gc in visual
Plug 'airblade/vim-gitgutter'           " Git diff in gutter
Plug 'tpope/vim-fugitive'               " Git commands in vim

" Styles
Plug 'mhartington/oceanic-next'

" Syntax check
" Plug 'vim-syntastic/syntastic'
Plug 'dense-analysis/ale'

" Terraform plugins
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'hashivim/vim-packer'

" Python
Plug 'mustache/vim-mustache-handlebars'
Plug 'vim-scripts/indentpython.vim'

" Yaml
Plug 'stephpy/vim-yaml'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

" node
Plug 'moll/vim-node'

" Other
Plug 'rodjek/vim-puppet'

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
set relativenumber              " Relative line numbers for easier motion
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
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
set updatetime=300              " Faster CursorHold events
set signcolumn=yes              " Always show sign column
set mouse=a                     " Enable mouse support

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

" fzf configuration - ignore external package directories
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/node_modules/*" -not -path "*/.venv/*" -not -path "*/venv/*" -not -path "*/vendor/*" -not -path "*/target/*" -not -path "*/dist/*" -not -path "*/build/*" -not -path "*/__pycache__/*" -not -path "*/.tox/*" -not -path "*/.pytest_cache/*" -not -path "*/.mypy_cache/*" -not -path "*/.uv/*" -not -name "*.pyc"'

" fzf mappings
nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>l :Lines<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Fold/Unfold
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" run current file
nnoremap <F9> :!%:p

" ale highlights
highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline

" Configure error/warning signs in the gutter
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Set specific colors for the signs
highlight ALEErrorSign ctermfg=red ctermbg=none
highlight ALEWarningSign ctermfg=yellow ctermbg=none

" Enable highlighting for errors and warnings
let g:ale_set_highlights = 1

" Set virtual text format
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '❯ '

" Configure hover behavior
let g:ale_hover_cursor = 1
let g:ale_hover_to_floating_preview = 1

"------------------------------------------------------------
" Golang Configs
"------------------------------------------------------------
" advanced syntax highligh
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" gopls integration
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_referrers_mode = 'gopls'
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" keyboard shortcuts
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>i  <Plug>(go-import)
autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>d <Plug>(go-def)
autocmd FileType go nmap gr <Plug>(go-rename)
autocmd FileType go nmap gD <Plug>(go-def-stack)
autocmd FileType go nmap <leader>v <Plug>(go-def-vertical)
autocmd FileType go nmap <leader>e <Plug>(go-iferr)
autocmd FileType go nmap <leader>s <Plug>(go-implements)
autocmd FileType go nmap <leader>cc <Plug>(go-coverage-toggle)

map <C-n> :cnext<CR>
nnoremap <leader>c :cclose<CR>
nnoremap <C-c> :cclose<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

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

" Automatically get signature/type info for object under cursor
let g:go_auto_type_info = 1

let g:go_metalinter_enabled = []
let g:go_metalinter_autosave = 0
let g:go_metalinter_command = ''

let g:ale_go_golangci_lint_options = '-e=ST1008'
let g:ale_go_golangci_lint_package = 1

let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

"------------------------------------------------------------
" Autocompletion + snippets
"------------------------------------------------------------
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-m>', '<Up>']
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_auto_hover = ''
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
set completeopt-=preview


"------------------------------------------------------------
" Python
"------------------------------------------------------------
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal textwidth=88
autocmd FileType python setlocal colorcolumn=88
autocmd FileType python nnoremap <buffer> <leader>r :!python3 %<CR>
autocmd FileType python nnoremap <buffer> <leader>t :!python3 -m pytest %<CR>

let g:ale_python_ruff_options = '--line-length=88'
let g:ale_python_black_options = '--line-length=88'
let g:ale_warn_about_trailing_whitespace = 0


let g:ale_linters = {
\   'go': ['golangci-lint'],
\   'python': ['ruff', 'mypy'],
\   'sh': ['shellcheck'],
\   'bash': ['shellcheck'],
\   'yaml': ['yamllint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['ruff', 'isort', 'black'],
\   'go': ['goimports'],
\   'sh': ['shfmt'],
\   'bash': ['shfmt'],
\}

" ALE behavior
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 100

" ALE navigation
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nnoremap <leader>af :ALEFix<CR>

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
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1
" let g:syntastic_python_checkers = ['python3', 'flake8']
" let g:syntastic_go_checkers = ['go', 'govet']


"------------------------------------------------------------
" Shell/Bash
"------------------------------------------------------------
autocmd FileType sh,bash setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType sh,bash nnoremap <buffer> <leader>r :!bash %<CR>

" shellcheck: ignore sourcing issues, allow following sourced files
let g:ale_sh_shellcheck_options = '-x -e SC1091'
" shfmt: indent=2, binary ops may start a line, indent switch cases
let g:ale_sh_shfmt_options = '-i 2 -bn -ci'

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
let g:terraform_registry_module_completion = 1
autocmd BufWritePre *.tf :TerraformFmt
autocmd BufRead,BufNewFile *.hcl set filetype=terraform

" Co-author macro - use :let @a = '<paste macro here>' to restore
" let @a = '0yyp0gu$0:.s/ /./e<CR>0:.s/ \\+//ge<CR>I<C-[>A@booking.com<C-[>kJICo-authored-by: <C-[>07wdt<i <C-[>0:.s/ \\+/ /ge<CR>:noh<CR>06wvU0k'

" Puppet formatting
function! FormatCode()
  let file = expand('%:p')
  if !filewritable(file)
    return
  endif
  noautocmd write
  let script_file =
        \ system('git rev-parse --show-toplevel')[:-2] .
        \ '/scripts/format-' . &filetype . '.sh'
  if v:shell_error != 0 || !filereadable(script_file)
    return
  endif
  let output = system(script_file . ' ' . file)
  if v:shell_error == 0
    let view = winsaveview()
    edit
    call winrestview(view)
  else
    echo output
  endif
endfunction
augroup format_code_on_save
  autocmd BufWriteCmd *.pp call FormatCode()
  autocmd BufWriteCmd *.yaml,*.eyaml,*.yml call FormatCode()
augroup end
