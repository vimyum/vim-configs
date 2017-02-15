if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,euc-jp,latin1
endif

set t_Co=256
set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler	" show the cursor position all the time
set number

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

if has("cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

set tabstop=4
set shiftwidth=4
set autoindent 
set smartindent 
set nonumber 
set showmatch
set backspace=2 
set autowrite 
set hid 
set shortmess+=I
set foldmethod=marker
"set foldmarker=/**,**/
set foldclose=all
set formatoptions=tcqr
filetype on
filetype plugin on
filetype indent on
let loaded_ruby_ftplugin = 1

syntax on
syntax enable
"colorscheme zellner
set tags=./tags,./../tags,./../../tags,./../../../tags,tags

map __ :noh
"map ci vi(c
map c" T"vt"c

map [c I{{{
map ]c o}}}

map _1 :e#1
map _2 :e#2
map _3 :e#3
map _4 :e#4
map _5 :e#5
map _6 :e#6
map _7 :e#7
map _8 :e#8
map _9 :e#9

map _m :wa:make
map _d :wa:make DEBUG="ON"
map _r :make run
map _w :wa

map \w :ccl<CR>

"my buff list
nmap gb :ls:buf  

"show status line
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set laststatus=4

imap   la
imap   i
imap   bgUeea

"setting for fold_digest
let folddigest_options = "vertical,flexnumwidth"
let folddigest_size = 20
hi Folded ctermfg=black

"if has('persisitent_undo')
set undofile
set undodir=~/.vimundo
"endif

"myScripts
map _c :r ~/.commentFormat
map _> :call M_com()
"map <silent> <F7> :call SearchFromTagList()o
map <silent> <F8> :call MyTagOpen()
map <silent> <F7> :Grep
set pastetoggle=<F11>
let Grep_Default_Filelist = '*.[ch]'

"for,if分を選択
nnoremap vb /{<CR>%v%0

"ハイライトグループを表示する
":echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

"for オムニ補完
autocmd FileType html :set filetype=xhtml
autocmd Filetype html :set omnifunc=htmlcomplete#CompleteTags
hi Pmenu ctermfg=gray ctermbg=blue

"showmarks.vim
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

set nocp

"yank&paste through file
map sy :.!tee /tmp/.vimYanku
map svy :!tee /tmp/.vimYanku
map sp :.!cat /tmp/.vimYank

map _b :%!xxd
map _B :%!xxd -r

cmap <C-j> <LEFT>
cmap <C-k> <RIGHT>

" enable mouse selection on only visula mode. (a:all, v:visual, n:normal,
" i:insert
set mouse=v
set ttymouse=xterm2

"text object like mapping
nmap ci_ T_ct_

"noremap  

colorscheme desert
"colorscheme default

" Bugfix for YankRing
let g:yankring_manual_clipboard_check = 0

" Setting for Bundle <#
set nocompatible
filetype off
 
set rtp+=~/.vim/vundle.git/
call vundle#rc()
 
"Bundle 'vimwiki'
"Bundle "YankRing.vim"
Bundle "minibufexpl.vim"
Bundle 'ref.vim'
"Bundle 'vcscommand.vim'
"Bundle 'git://github.com/Shougo/vimproc'
"Bundle 'git://github.com/Shougo/neocomplcache'
"Bundle 'clang-complete'
Bundle 'matchit.zip' 
Bundle 'vim-js-indent' 
Bundle 'surround.vim'

" github の任意のリポジトリ
Bundle "tpope/vim-fugitive"
Bundle "vimyum/videm"

" github 以外のリポジトリ (3)
"Bundle "git://git.wincent.com/command-t.git"
filetype plugin indent on

au BufNewFile,BufRead *.videm	setf videm
au BufNewFile,BufRead *.tr	setf ns2tr

set nowrap

nmap ,ra :<C-u>Ref alc<Space>
let g:ref_alc_start_linenumber = 39

"Settings for VIDEm
nmap MM :VidemMenu MM<CR>:<BS>
nmap MW :VidemNaviToggle<CR>:<BS>
"nmap MW :VidemToggleWin<CR>:<BS>

"setting for tag_list 
Bundle 'taglist.vim'
Bundle 'fugitive.vim'
"let g:Tlist_Use_Horiz_Window=1
map  :TlistToggle
let Tlist_GainFocus_On_ToggleOpen = 0
"let Tlist_Close_On_Select = 1

" For Minibuf Explore
hi StatusLineNC ctermfg=5 ctermbg=5
nmap <silent>H :call MvBuffNext_()<CR>:<BS>
nmap <silent>L :call MvBuffPrev_()<CR>:<BS>
function! MvBuffNext_()
	exe "bNext"
	while getbufvar("%","&filetype") == "qf"
		exe "bNext"
	endwhile
endf
function! MvBuffPrev_()
	exe "bnext"
	while getbufvar("%","&filetype") == "qf"
		exe "bnext"
	endwhile
endf

" Quick Fix Window
nmap cl :ccl<CR>:<BS>
nmap co :copen 5<CR>:<BS>
nmap cn :cn<CR>:<BS>
nmap cj :cc<CR>:<BS>

nmap g" ysaw"<CR>:<BS>

colorscheme desert256
colorscheme viske.dark256

hi ViskeTask5 ctermbg=240 ctermfg=237
let g:viskeGcalId = "tsagara@gmail.com"
let g:viskeGcalTZone = "+0900"
"let g:viskeSyncNoConfirm = 1
let g:ViskeTaskTypeLabel = ['\ ', '仕事', '重要', '家庭', 'キャンセル', '備考/TODO']
cal viske#setSyncFunc("viske#gcal")
let g:viskeCalLang="JP"

let g:clang_complete_auto=1
let g:clang_use_library=1
let g:clang_use_library="/usr/share/clang"
set completeopt=menuone

nmap gj :call SendBottom()<CR>:<BS> 
vmap gj :call SendBottom()<CR>:<BS>
"nmap  :call ClearBottom()<CR>:<BS>
"nmap  :call BsBottom()<CR>:<BS>

nmap m/ <leader>mi
endfunction

func! MkConsole(margin) range
	let max_row = 0
	let now_row = 0
	" Count Max Col
	cal cursor(a:firstline, 1)
	while 1
		let now_row = col("$")
		if (now_row >= max_row)
			let max_row = now_row
		endif
		cal cursor(line(".") + 1, 1)
		if (line(".") >= a:lastline)
			break
		endif
	endwhile
	echo max_row
	let max_row = max_row + a:margin
	
	" Count Max Col
	cal cursor(a:firstline, 1)
	while 1
		let padlen  = max_row - col("$")
		let pad     = repeat(" ", padlen)
		cal setline(line("."), getline(".") . pad)
		cal cursor(line(".") + 1, 1)
		if (line(".") >= a:lastline)
			break
		endif
	endwhile
endf

vmap <silent>gc :call MkConsole(2)<CR>:<BS>

inoremap <buffer><nowait> <m-]> <esc>
inoremap <buffer><nowait> <M-p> <C-p>

source $VIMRUNTIME/macros/matchit.vim

func! JsonTo()
	exe "%s/\\//g"
	exe "%!jq '.'"
endf
func! ToJson()
	exe '%s/\n//g'
	exe '%s/\s//g'
	exe '%s/"/\\"/g'
endf
vmap <C-c> :w !xsel -ib<CR><CR>

set expandtab
