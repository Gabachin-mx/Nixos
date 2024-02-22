"Use Vundle plugin manager

set nocompatible             
filetype off  
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'bling/vim-bufferline'
Plugin 'preservim/nerdtree'
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf.vim'
Plugin 'danro/rename.vim'
Plugin 'w0rp/ale'
Plugin 'junegunn/goyo.vim'
Plugin 'bloc40/vim-replace'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'mkitt/tabline.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'morhetz/gruvbox'
Plugin 'nanotech/jellybeans.vim'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
" Plugin 'luochen1990/rainbow'
Plugin 'lnl7/vim-nix'
Plugin 'frazrepo/vim-rainbow'
" Plugin 'junegunn/rainbow_parentheses.vim'
call vundle#end()            

filetype plugin indent on 

colorscheme gruvbox

set bg=dark

" Enable CursorLine
set cursorline
" Default Colors for CursorLine
" highlight  CursorLine ctermbg=LightGreen ctermfg=None

autocmd InsertEnter * highlight  CursorLine ctermbg=Blue ctermfg=Red

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=DarkGray ctermfg=None

" Add full file path to your existing statusline (for airline plugin)
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'"Special keybindings and operations
"
" Copy paste to external programs (requires gvim)
set clipboard=unnamed

nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
"
" Set cursor to beam in Insert Mode, Block otherwise
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Set NerdTree width
:let g:NERDTreeWinSize=15

""toggle tree on and off
" nnoremap <C-space> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

"show hidden files by default
let NERDTreeShowHidden=1

"change leader to space bar
let mapleader = "\<space>"

" quick-save
nmap <leader>w :w<CR>

" save read-only files 
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" quit vim entirely
nmap <leader>q :qa<CR>

" close buffer without changing window layout
nnoremap :: :bp\|bd #<CR>

 " :W sudo saves the file
 " (useful for handling the permission-denied error)
 command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
 
 " Set 7 lines to the cursor - when moving vertically using j/k
set so=7
 
"switch between buffers in normal mode
map gn :bnext<cr>
map gp :bprevious<cr>
map gd :bdelete<cr>  

" I personally use <leader> 
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
map <leader>d :bdelete<cr>

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

" Start NERDTree and put the cursor back in the other window. (uncomment so tree does not launch when vim is opened)
" autocmd VimEnter * NERDTree | wincmd p

" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually jus
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=

" URL: https://vim.wikia.com/wiki/Example_vimrc
" Authors: https://vim.wikia.com/wiki/Vim_on_Libera_Chat
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Set search highlight colors
set hlsearch
hi Search ctermbg=LightYellow
hi Search ctermfg=Red

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
"
" vv to generate vertical split of the file
nnoremap <silent>vf <C-w>v

" vn to generate horizontal split create NEW file
nnoremap <silent>hn <C-w>n

" vn to generate vertical split create NEW file
nnoremap <leader>vn :vnew<CR> 

" make files modifiable
set ma

" Better command-line completion

set wildmenu
set wildmode=full

"cursor goes to actual end of the line
set ve+=onemore

" Show partial commands in the last line of the screen
set showcmd

" Show matching brackets when text indicator is over them
set showmatch
 
" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left
set foldcolumn=0
set number

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
" set cmdheight=2
set cmdheight=1

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
"set shiftwidth=4
"set softtabstop=4
"set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4

" Use spaces instead of tabs
set expandtab
 
" Be smart when using tabs ;)
set smarttab
 
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
 
" Linebreak on 500 characters
set lbr
set tw=500
 
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" move line up or down
"add the following to ~/.vimrc file (make sure you have no mapping for n,m )
nmap <A-d> :m +1<CR>
nmap <A-u> :m -2<CR>

"select all contents of file
nnoremap <C-A> ggVG
"------------------------------------------------------------

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Colors for tab plugin
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" add lines below and above current line
map <Enter> o<ESC>
map <S-Enter> O<ESC>

""When entering insert mode, relative line numbers are turned off, leaving absolute line numbers turned on.
"augroup numbertoggle
"autocmd!
"autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
"autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
"augroup END

function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set nonumber
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" comment out lines
augroup comment_like_a_boss
    autocmd!
    autocmd FileType c,cpp,go                          let b:comment_leader = '// '
    autocmd FileType ruby,python                       let b:comment_leader = '# '
    autocmd FileType conf,fstab,sh,bash,tmux,yaml,toml let b:comment_leader = '# '
    autocmd FileType tex                               let b:comment_leader = '% '
    autocmd FileType mail                              let b:comment_leader = '> '
    autocmd FileType vim                               let b:comment_leader = '" '
    autocmd FileType txt                               let b:comment_leader = '# '
augroup END
noremap <silent> <leader>gc :<C-b>silent <C-e>norm ^i<C-r>=b:comment_leader<CR><CR>
noremap <silent> <leader>gu :<C-b>silent <C-e>norm ^xx<CR>

" another way to comment out lines (requires Commentary plugin)
noremap <leader>/ :Commentary<cr>

" Backup configuration
set backupdir=~/vimtmp//,.
set directory=~/vimtmp//,.
" The first line is for backup files, the second line for swap files. The double slash at the end ensures that there is no conflict in case of two files having the same name, see comments (at the time of this edit this option is only honored for swap files, not yet for backup files). The ,. allow vim to use the current directory if the former doesn't exist.

" You have to create a directory in your home directory called vimtmp for this to work. Also, check that backups are enabled in your config (add set backup if not).

" remap kj to escape
" esc in insert & visual mode
inoremap kj <esc>
vnoremap kj <esc>

" esc in command mode
cnoremap kj <C-C>
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" existing which is Ctrl-C
"
" Note: If you do need to type a literal kj (or whatever your mapping is) just type them with 2 seconds in between. (You'll see the cursor hesitate to move after the 1st char. Wait for it to move before typing the 2nd.)

" You can shorten this delay by setting a shorter timeout to timeoutlen. For example, to have a timeout of 500ms add the following to your vimrc:

set timeoutlen=500
"-------------------------------------------------------------
"Limelight for a selected range
nmap <leader>f <Plug>(Limelight)
xmap <leader>f <Plug>(Limelight)
"toggle Limelight off
nmap <leader>F :Limelight!<CR>

" For some color schemes, Limelight may not be able to calculate the color for dimming down the surrounding paragraphs. In that case, you need to define g:limelight_conceal_ctermfg or g:limelight_conceal_guifg
"
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
 
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
"----------------------------------------------------------------------------
"
noremap <leader>fg :Goyo<CR>
vnoremap  <leader>fg :Goyo<CR>
"toggle Goyo off
nmap <leader>G :Goyo!<CR>

" Goyo integration with limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Autocomplete braces
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

" Enable rainbow plugin
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
