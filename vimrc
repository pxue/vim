" Debug
"let g:syntastic_debug = 3
"let g:go_debug = ['lsp']
"
" Last updated: Feb, 2016
" Note: Spring cleaning...

" Preamble ---------------------------------------------------------- {{{
" turn filetype detection off and, even if it's not strictly
" necessary, disable loading of indent scripts and filetype plugins
filetype off
filetype plugin indent off

call pathogen#infect()
call pathogen#helptags()

" turn filetype detection, indent scripts and filetype plugins on
" and syntax highlighting too
filetype plugin indent on
set nocompatible

" Basic options ----------------------------------------------------- {{{
set number
set ruler
syntax on

" encoding, by default nvim sets it to utf8
if !has('nvim')
    set encoding=utf-8
endif

set showmode
set hidden
set visualbell
" set cursorline
set ttyfast
set history=1000
set undofile
set undoreload=5000
set shell=/bin/bash
set lazyredraw
set splitbelow
set splitright
" set ttimeout
" set notimeout
" set nottimeout
set autowrite
set shiftround
set autoread
set title
set mouse=a
set showmatch
set diffopt=iwhite

" SGR protocol
if has("mouse_sgr")
    set ttymouse=sgr
end

set t_Co=256

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" }}}

" Wildmenu completion {{{

set wildmenu
set wildmode=list:longest,list:full
set wildignore+=.hg,.git,.svn                       " Version control
set wildignore+=.aux,*.out,*.toc                    " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " compiled obj files

set wildignore+=*.pyc                               " compiled python bytecode
set wildignore+=*.rbc                               " compiled ruby bytecode
" set wildignore+=migrations                        " django migrations
set wildignore+=*/bin/*

set wildignore+=vendor/gems/*                       " gems
set wildignore+=*/node_modules/*                      " node_modules
set wildignore+=*/sourcemaps/*                        " source maps

set wildignore+=*.orig                              " hg backup files

set wildignore+=.DS_Store                           " Mac OSX

" Rails specific ignores
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/vendor/*
set wildignore+=*/Godeps/*
set wildignore+=*/spec/vcr/*
set wildignore+=*/public/*
set wildignore+=*/chef/*
set wildignore+=*/coverage/*
set wildignore+=*/log/*
set wildignore+=*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig

" gulp
set wildignore+=*/build/*
set wildignore+=*/.build/*

" other
set wildignore+=*.*~,*~,*.swo,*.swp,*.swm,*.swn    " vim swap
set wildignore+=*/env/*,*/ENV/*,*/virtualenv/*     " local virtual env

" ai stuff
set wildignore+=*.noun,*.sense

" jest stuff
set wildignore+=*/__coverage__/*

" disable omnicomplete from sql
let g:omni_sql_no_default_maps = 1


" {{{

" Save when losing focus
"au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Backups {{{
set undodir=~/.vim/tmp/undo/       " undo files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set backup

" }}}

" Tabs, spaces, wrapping {{{
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80
set nowrap
set formatoptions+=qrnl1
"set list listchars=tab:\ \ ,trail:·

au! FileType javascript :setlocal sw=2 ts=2 sts=2
au! FileType jade :setlocal sw=2 ts=2 sts=2
au! FileType stylus :setlocal sw=2 ts=2 sts=2
au! FileType sh :setlocal sw=2 ts=2 sts=2
au! FileType toml :setlocal sw=2 ts=2 sts=2
au! FileType html :setlocal sw=2 ts=2 sts=2
au! FileType qf setlocal wrap

" Scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Local vimrc support
:set exrc

" Default colour scheme
color wombat256

" map leader key
let mapleader = ","
let maplocalleader = "\\"

" }}}
"
" Useful shortcuts {{{
"
" Delete word undercursor in insert mode
:imap <C-d> <C-[>diwi

" Insert Mode Movement
imap <C-b> <Esc>`^bi
imap <C-w> <Esc>`^wi
imap <C-a> <Esc>`^Ai

" Inline edit
map <Leader>i :InlineEdit<CR>

" Save with control-s
map <C-s> :w!<CR>
imap <C-S> <Esc>`^:w!<CR>i

" Quit with control-q
map <C-q> :wq!<CR>
imap <C-Q> <Esc>:wq!<CR>

" Easier tab navigation
nnoremap <silent> <C-t> :tabnew<CR>

" Searching
map N Nzz
map n nzz

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Map j/k for popup menu when visible
" inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "j"
" inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "k"

" Set Paste ON/OFF
"map <C-p> :set paste<CR>
"map <S-p> :set nopaste<CR>
"

" map zencoding
"let g:user_emmet_leader_key='<Leader>e'

" Go Vim (vim-go)
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 0
let g:go_metalinter_autosave = 0
let g:go_metalinter_command = ""
let g:go_def_mapping_enabled = 0
let g:go_dispatch_enabled = 1
let g:go_doc_keywordprg_enabled = 1
let g:go_list_type = "quickfix"
let g:go_def_mode = 'gopls'
let g:go_info_mode='gopls'
let g:go_addtags_transform = 'camelcase'
"let g:go_auto_type_info = 1

au FileType go nmap gd <Plug>(go-def-vertical)
au FileType go nmap <silent> gi <Plug>(go-implements)
au FileType go nmap <silent> gl :GoDecls<CR>

"
" Neomake
let g:neomake_open_list = 2
"let g:neomake_verbose = 1
"let g:neomake_logfile = $PWD .'neomake.log'

let g:neomake_warning_sign = {
    \   'text': '!!',
    \   'texthl': 'Todo',
    \ }

"" use syntastic like error sign
let g:neomake_error_sign = {
    \ 'text': '>!',
    \ 'texthl': 'NeomakeErrorSign',
    \ }

let g:neomake_go_go_maker = {
    \ 'exe': 'CGO_CFLAGS=-w CGO_CPPFLAGS=-w go',
    \ }
autocmd! BufWritePost *.go Neomake

" jsx
let g:jsx_ext_required = 0
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

let g:neomake_javascript_eslint_maker = {
  \ 'exe': $PWD . '/node_modules/.bin/eslint',
  \ 'args': ['--format=compact'],
  \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
  \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#',
  \ 'cwd': '%:p:h',
  \ 'output_stream': 'stdout',
  \ }

autocmd! BufWritePost *.js Neomake
autocmd! BufWritePost *.ts Neomake
autocmd! BufWritePost *.tsx Neomake
autocmd! BufWritePost *.jsx Neomake
autocmd! BufWritePost *.jsw Neomake

" python
"let g:neomake_python_enabled_makers = ['pylint']
autocmd! BufWritePost *.py Neomake

"
" Neofmt
"let g:neoformat_verbose = 1
" let g:neoformat_try_node_exe = 1
" autocmd BufWritePre *.js Neoformat
" autocmd BufWritePre *.ts Neoformat
" autocmd BufWritePre *.jsx Neoformat
" autocmd BufWritePre *.tsx Neoformat
" autocmd BufWritePre *.jsw Neoformat
" autocmd BufWritePost *.ts Neoformat
" autocmd BufWritePost *.tsx Neoformat

" let g:neoformat_only_msg_on_error = 1
" let g:neoformat_enabled_javascript = ['prettier']
" let g:neoformat_enabled_typescript = ['prettier']
" let g:neoformat_enabled_html = ['prettier']
"let g:neoformat_javascript_prettier = {
            "\ 'exe': 'prettier',
            "\ 'args': ['--print-width 80'],
            "\ }

" neovim coc
au FileType typescript nmap <silent> gd <Plug>(coc-definition)
au FileType typescript nmap <silent> gy <Plug>(coc-type-definition)
au FileType typescript.tsx nmap <silent> gd <Plug>(coc-definition)
au FileType typescript.tsx nmap <silent> gy <Plug>(coc-type-definition)
" Map j/k for pum OR coc#pum when visible
inoremap <expr> <C-J> coc#pum#visible() ? coc#pum#next(1) : pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-K> coc#pum#visible() ? coc#pum#prev(1) : pumvisible() ? "\<C-P>" : "k"
" Coc highlight
hi DiagnosticInfo ctermfg=230
hi DiagnosticWarn ctermfg=230
hi DiagnosticError ctermfg=230
hi CocMenuSel ctermbg=143 guibg=#13354A

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

"
" Toggle quick/location list
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
"nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

" Status line ------------------------------------------------------
set laststatus=2

" Show (partial) command in the status line
set showcmd

augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

set statusline=%f       " Path.
set statusline+=%m      " Modified flag.
set statusline+=%r      " Readonly flag.
set statusline+=%w      " Preview window flag

set statusline+=\       " Space.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c)

" File types
" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=json

" Wix jsw modules
au BufNewFile,BufRead *.jsw set ft=javascript

" Jsx typescript
au BufNewFile,BufRead *.tsx set ft=typescript.tsx

" ruby shift/soft tab width
au BufNewFile,BufRead *.rb setlocal softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rake setlocal softtabstop=2 shiftwidth=2

" go template shiftwidth
au filetype gohtmltmpl setlocal softtabstop=2 shiftwidth=2

" python auto yapf
"au Filetype python au BufWritePre <buffer> call yapf#YAPF()

" {{{
" Function mappings ---------------------------------------------------------

"
" Ack-grep in vim
"let g:ackprg="ack-grep -H -i -l --no-color --group --nocolumn --nofollow --max-count=1"
let g:ackprg="ack -H --group --nocolumn --type-add=tsx:ext:tsx --type-add=ts:ext:ts --ignore-dir={__coverage__,ENV,dist,tmp,build,.build,.vendor,log,vendor,sourcemaps,node_modules,.venv}"
silent! nmap <unique> <silent> <Leader>f :Ack<space>

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\.DS_Store', '\~$', '__pycache__', 'node_modules']
map <Leader>b :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" ControlP configuration
let g:ctrlp_map = "<Leader>t"
let g:ctrlp_cmd = "CtrlP"

let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = '\v[\/]\.(vendor)$'

map <Leader>cp :ClearCtrlPCache<CR>

" Vim markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<Leader>p'
let vim_markdown_preview_browser='Google Chrome'

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Project Tree
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
"autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()


" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function! s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0 
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function! s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

" Utility functions to create file commands
function! s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function! s:FileCommand(name, ...)
  if !exists("a:name")
    let funcname = a:name
    execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
  endif
endfunction

function! s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function! ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function! Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function! Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function! Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function! Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . fnameescape(a:file)

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^"  Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")
call s:DefineCommand("mkdir", "Mkdir")

" auto set paste on copy from system
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" yank to system on OSX
function! ClipboardYank()
  call system('pbcopy', @@)
endfunction

" yank to OSX clipboard
vnoremap <silent> <Leader>y y:call ClipboardYank()<cr>
" quick edit vimrc in vsplit
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
