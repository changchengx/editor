set shell=/bin/bash
set title   " change the terminal's title

set background=light
colorscheme zellner

" F2切换行号显示
nnoremap <F1> :set nonu!<CR>:set foldcolumn=0<CR>
function Sdcvword()
    let wordUnderCursor = expand("<cword>")
    execute '!sdcv' wordUnderCursor
endfunction
nmap <silent>  <F2>  :call Sdcvword()<CR>



" F3 open directory file tree
nmap <silent> <F7> :NERDTreeToggle<CR>

" set the ignored file filter without showing them
let NERDTreeIgnore=['\.pyc$', '\~$']

" show nerdtree when starts up
"autocmd vimenter * NERDTree
" 退出最后一个buff时也退出nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" 保存文件时自动删除行尾空格或Tab
autocmd BufWritePre * :%s/\s\+$//e

" 保存文件时自动删除末尾空行
autocmd BufWritePre * :%s/^$\n\+\%$//ge

set number
set numberwidth=6

set confirm     " Y-N-C prompt if closing with unsaved changes.

setlocal sta sw=4 sts=4 ts=4
"set tabstop=2    " Set the default tabstop
"set softtabstop=2
"set shiftwidth=2 " Set the default shift width for indents
"set expandtab   " Make tabs into spaces (set by tabstop)
"set smarttab " Smarter tab levels
""" Moving Around/Editing
"set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time

" 左右分割窗口Ctrl+w +v
" 上下分割窗口Ctrl+w +s
" 关闭窗口Ctrl+w  +q

"Folding
"set foldmethod=syntax
"set foldlevelstart=10
"set foldcolumn=1

set novisualbell  " No blinking
set noerrorbells  " No noise.

set tags=tags;$HOME " walk directory tree upto $HOME looking for tags
" 这样使用tags时可以首先在当前目录下查找tags文件，如果没有则转到父目录查找。依次向上。
" set autochdir


"set hidden " The current buffer can be put to the background without writing to disk
set hlsearch    " Highlight searches by default.
"set incsearch  " Incrementally search while typing a /regex
set ignorecase  " Default to using case insensitive searches,
set smartcase   " unless uppercase letters are used in the regex.
set showmatch   "Show matching brackets.
"set smarttab   " Handle tabs more intelligently

syntax on

"laststatus选项用于指定何时最近使用的窗口会有一个状态行:
"0  永远没有
"1  只有分隔窗口时(默认值)
"2  总是存在
set laststatus=2
"预设为unix格式，但如果载入的是dos格式的档案，会自动调整为dos格式，这样存档时就会以dos格式存档
set ffs=unix,dos ff=unix
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set hlsearch

"TAB会被显示成">-",行尾多余的空白字符显示成'-'
"https://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character/29787362#29787362
set listchars=eol:¬,tab:>-,trail:-,extends:>,precedes:<
"添加空白显示字符
"set listchars+=space:␣
"set list
"set nolist

"让vim可以自动断行，触发点是当前行已超过78个字符了。但是只对文件类型是普通文本的文件有效。
"audocmdFileType text"
"是一个自动命令。它所定义的是每当文件类型被设置为text时就自动执行它后面的命令。
"setlocal textwidth=78"
"把textwidth选项的值设置为78，但这种设置只对当前的一个文件有效
"autocmd FileType text setlocal textwidth=78

"让vim在开始一个新行时对该行施以上一行的缩进方式。这样，在insert模式下按回车或在normal模式下按o来添加新行时，该行将会与上一行有相同的缩进
set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)

set fileencodings=utf-8,gbk

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
" 调到光标下tag所定义的位置，用鼠标双击此tag功能也一样
" <CR>
" <Space>       显示光标下tag的原型定义
" u             更新taglist窗口中的tag
" s             更改排序方式，在按名字排序和按出现顺序排序间切换
" x             taglist窗口放大和缩小，方便查看较长的tag
" +             打开一个折叠，同zo
" -             将tag折叠起来，同zc
" *             打开所有的折叠，同zR
" =             将所有tag折叠起来，同zM
" [[            跳到前一个文件
" ]]            跳到后一个文件
" q             关闭taglist窗口

"在启动 vim 后，自动打开 taglist 窗口
"Tlist_Auto_Open=1
" 可以用":TlistOpen"打开taglist窗口，用":TlistClose"关闭taglist窗口
" 或者使用":TlistToggle"在打开和关闭间切换
" map <silent> <F9> :TlistToggle<cr>
map <silent> <F9> :TagbarToggle<cr>

"不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File = 1
"当同时显示多个文件中的tag时，设置Tlist_File_Fold_Auto_Close为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来。
let Tlist_File_Fold_Auto_Close=1

"设置taglist窗口横向显示
"Tlist_Use_Horiz_Window=1

"如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow = 1

"在右侧窗口中显示taglist窗口
let Tlist_Use_Right_Window = 1
"let Tlist_Use_Left_Window=1

let Tlist_Use_SingleClick=1
let Tlist_WinWidth=50
"let Tlist_Use_SingleClick=1  "单击跳转到定义
"let Tlist_Auto_Open=1 "自动打开tglist
"let Tlisg_GainFocus_On_ToggleOpen=1  "在使用:TlistToggle打开taglist窗口时，如果希望输入焦点在taglist窗口中，设置Tlist_GainFocus_On_ToggleOpen为1

"----------------------VBUNDLE template start-----------------------"
set nocompatible              " be iMproved, required
filetype off                  " required


" ===========================================================
" FileType specific changes
" ============================================================
" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2





" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"-------------start----------"
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" ------------zero------------"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

"---------from github---------"
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'

"---------from vim scripts----"
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

"-----not hosted on github----"
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

"------own local plugin------"
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

"------customize plugin------"
" EXAMPLE ONE:
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" EXAMPLE TWO:
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
"------------- end ----------"

" 针对不同的文件类型采用不同的缩进格式
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


"----------vbundle help command--------"
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Install Plugins:
" Launch vim and run :PluginInstall
" To install from command line: vim +PluginInstall +qall
"----------------------VBUNDLE template end -----------------------"


"-------- put none plugin stuffer after this line"
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_max_num_candidates = 50
let g:ycm_max_num_identifier_candidates = 50
let g:ycm_filetype_whitelist = {'*': 1}
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}

let g:ycm_filepath_blacklist = {
      \ 'html': 1,
      \ 'jsx': 1,
      \ 'xml': 1,
      \}

let g:ycm_complete_in_comments = 0
"This is very useful for instance in C-family files where typing #include " will trigger the start of filename completion.
"If you turn off this option, you will turn off filename completion in such situations as well.
let g:ycm_complete_in_strings=0
let g:ycm_collect_identifiers_from_comments_and_strings=0

" Ctags needs to be called with the --fields=+l option
let g:ycm_collect_identifiers_from_tags_files=1

set splitbelow
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

"if has("cscope")
"   set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
"
"   " check cscope for definition of a symbol before checking ctags:
"   " set to 1 if you want the reverse search order.
"   set csto=1
"
"   " add any cscope database in current directory
"   if filereadable("cscope.out")
"       cs add cscope.out
"   endif
"
"   " show msg when any other cscope db added
"   set cscopeverbose
"
"   ":cs find s ---- 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
"   nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"
"   ":cs find g ---- 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
"   nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"
"   ":cs find c ---- 查找调用本函数的函数
"   nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"   ":cs find d ---- 查找本函数调用的函数
"   nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"
"   ":cs find t: ---- 查找指定的字符串
"   nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"
"   ":cs find e ---- 查找egrep模式，相当于egrep功能，但查找速度快多了
"   nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"
"   ":cs find f ---- 查找并打开文件，类似vim的find功能
"   nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"
"   ":cs find i ---- 查找包含本文件的文
"   nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"endif
