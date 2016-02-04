" Last updated: Feb, 2016
" Note: Spring cleaning...

" Preamble ---------------------------------------------------------- {{{
filetype off
call pathogen#infect()
filetype plugin indent on
set nocompatible

" Basic options ----------------------------------------------------- {{{
set number
set ruler
syntax on

" encoding
set encoding=utf-8

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
set wildignore+=node_modules/*                      " node_modules

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

" {{{

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Backups {{{
set undodir=~/.vim/tmp/undo//       " undo files
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
set list listchars=tab:\ \ ,trail:·

au! FileType javascript :setlocal sw=2 ts=2 sts=2
au! FileType jade :setlocal sw=2 ts=2 sts=2
au! FileType stylus :setlocal sw=2 ts=2 sts=2
au! FileType sh :setlocal sw=2 ts=2 sts=2

" Scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

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

" system clipboard copying in visual mode
"vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
"

" Insert Mode Movement
imap <C-b> <Esc>`^bi
imap <C-w> <Esc>`^wi
imap <C-a> <Esc>`^Ai

" Inline edit
map <Leader>i :InlineEdit<CR>

" Save with control-s
map <C-s> :w<CR>
imap <C-S> <Esc>`^:w<CR>i

" Quit with control-q
map <C-q> :wq<CR>
imap <C-Q> <Esc>:wq<CR>

" Easier tab navigation
nnoremap <silent> <C-t>     :tabnew<CR>

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

" Set Paste ON/OFF
"map <C-p> :set paste<CR>
"map <S-p> :set nopaste<CR>
"

" map zencoding
let g:user_zen_expandabbr_key='<Leader>e'
let g:user_zen_next_key='<Leader>zn'
let g:user_zen_prev_key='<Leader>zN'

" Powerline
let g:Powerline_stl_path_style = 'filename'
call Pl#Theme#InsertSegment('was_marker', 'after', 'lineinfo')

" Go Vim (vim-go)
let g:go_fmt_command = "goimports"
"let g:go_fmt_autosave = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 1
let g:go_fmt_fail_silently = 1

au FileType go nmap gd <Plug>(go-def-vertical)
au FileType go nmap gb <Plug>(go-doc-browser)

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 0
"let g:syntastic_auto_jump = 3
let g:syntastic_aggregate_errors = 1

silent! au FileType go nmap <silent> <Leader>s :SyntasticCheck<CR>

"let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_go_checkers = ['go']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" }}}
"

"{{{
" Status line ------------------------------------------------------ {{{
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

" ruby shift/soft tab width
au BufNewFile,BufRead *.rb setlocal softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rake setlocal softtabstop=2 shiftwidth=2


" }}}
" Django {{{

augroup ft_django
    au!

    au BufNewFile,BufRead urls.py           setlocal nowrap
    au BufNewFile,BufRead urls.py           normal! zR
    au BufNewFile,BufRead dashboard.py      normal! zR
    au BufNewFile,BufRead local_settings.py normal! zR

    au BufNewFile,BufRead admin.py     setlocal filetype=python.django
    au BufNewFile,BufRead urls.py      setlocal filetype=python.django
    au BufNewFile,BufRead urls.py      setlocal textwidth=0 tabstop=8
    au BufNewFile,BufRead models.py    setlocal filetype=python.django
    au BufNewFile,BufRead views.py     setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal foldmethod=marker
    au BufNewFile,BufRead forms.py     setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal foldmethod=marker
augroup END


" }}}


" {{{
" Function mappings ---------------------------------------------------------

"
" Ack-grep in vim
"let g:ackprg="ack-grep -H -i -l --no-color --group --nocolumn --nofollow --max-count=1"
let g:ackprg="ack -H --group --nocolumn --ignore-dir={.vendor,log,vendor}"
silent! nmap <unique> <silent> <Leader>f :Ack<space>

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" ControlP configuration
let g:ctrlp_map = "<Leader>t"
let g:ctrlp_cmd = "CtrlP"

let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = '\v[\/]\.(vendor)$'

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Project Tree
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()


" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
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
function s:UpdateNERDTree(...)
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
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Edit(file)
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

vnoremap <silent> <Leader>y y:call ClipboardYank()<cr>
