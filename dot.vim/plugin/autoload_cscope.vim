" Vim global plugin for autoloading cscope databases.
" Last Change: Wed Jan 26 10:28:52 Jerusalem Standard Time 2011
" Maintainer: Michael Conrad Tadpol Tilsra <tadpol@tadpol.org>
" Revision: 0.5

if exists("loaded_autoload_cscope")
	finish
endif
let loaded_autoload_cscope = 1

" requirements, you must have these enabled or this is useless.
if(  !has('cscope') || !has('modify_fname') )
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

" If you set this to anything other than 1, the menu and macros will not be
" loaded.  Useful if you have your own that you like.  Or don't want my stuff
" clashing with any macros you've made.
if !exists("g:autocscope_menus")
  let g:autocscope_menus = 1
endif

"==
" windowdir
"  Gets the directory for the file in the current window
"  Or the current working dir if there isn't one for the window.
"  Use tr to allow that other OS paths, too
function s:windowdir()
  if winbufnr(0) == -1
    let unislash = getcwd()
  else
    let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')
  endif
    return tr(unislash, '\', '/')
endfunc
"
"==
" Find_in_parent
" find the file argument and returns the path to it.
" Starting with the current working dir, it walks up the parent folders
" until it finds the file, or it hits the stop dir.
" If it doesn't find it, it returns "Nothing"
function s:Find_in_parent(fln,flsrt,flstp)
  let here = a:flsrt
  while ( strlen( here) > 0 )
    if filereadable( here . "/" . a:fln )
      return here
    endif
    let fr = match(here, "/[^/]*$")
    if fr == -1
      break
    endif
    let here = strpart(here, 0, fr)
    if here == a:flstp
      break
    endif
  endwhile
  return "Nothing"
endfunc
"
"==
" Cycle_macros_menus
"  if there are cscope connections, activate that stuff.
"  Else toss it out.
"  TODO Maybe I should move this into a seperate plugin?
let s:menus_loaded = 0
function s:Cycle_macros_menus()
  if g:autocscope_menus != 1
    return
  endif
  if cscope_connection()
    if s:menus_loaded == 1
      return
    endif
    let s:menus_loaded = 1

	" 同时搜索cscope数据库和标签文件
    " set cst

	" 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库
    " set csto=1

	" 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
	" set cscopetag

	":cs find d ---- 查找本函数调用的函数
    silent! nmap <unique> <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    silent! nmap <unique> <C-l>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

	":cs find c ---- 查找调用本函数的函数
    silent! nmap <unique> <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    silent! nmap <unique> <C-l>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>

	":cs find g ---- 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
    silent! nmap <unique> <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    silent! nmap <unique> <C-l>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>

	":cs find t: ---- 查找指定的字符串
    silent! nmap <unique> <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    silent! nmap <unique> <C-l>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>

	":cs find f ---- 查找并打开文件，类似vim的find功能
    silent! nmap <unique> <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
    silent! nmap <unique> <C-l>f :vert scs find f <C-R>=expand("<cword>")<CR><CR>

	":cs find i ---- 查找包含本文件的文
	"WA, not right purpose
    silent! nmap <unique> <C-\>i :cs find i <C-R>=expand("<cword>")<CR><CR>
    silent! nmap <unique> <C-l>i :vert scs find i <C-R>=expand("<cword>")<CR><CR>

	":cs find s ---- 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
    "silent! nmap <unique> <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    "silent! nmap <unique> <C-l>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>

	":cs find e ---- 查找egrep模式，相当于egrep功能，但查找速度快多了
    "silent! nmap <unique> <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    "silent! nmap <unique> <C-l>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>

    if has("menu")
      nmenu &Cscope.Find.Symbol<Tab><c-\\>s
        \ :cs find s <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.Definition<Tab><c-\\>g
        \ :cs find g <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.Called<Tab><c-\\>d
        \ :cs find d <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.Calling<Tab><c-\\>c
        \ :cs find c <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.Assignment<Tab><c-\\>t
        \ :cs find t <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.Egrep<Tab><c-\\>e
        \ :cs find e <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.File<Tab><c-\\>f
        \ :cs find f <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Find.Including<Tab><c-\\>i
        \ :cs find i <C-R>=expand("<cword>")<CR><CR>
      nmenu &Cscope.Reset :cs reset<cr>
      nmenu &Cscope.Show :cs show<cr>
      " Need to figure out how to do the add/remove. May end up writing
      " some container functions.  Or tossing them out, since this is supposed
      " to all be automatic.
    endif
  else
    let s:menus_loaded = 0
    set nocst
    silent! unmap <C-\>s
    silent! unmap <C-\>g
    silent! unmap <C-\>d
    silent! unmap <C-\>c
    silent! unmap <C-\>t
    silent! unmap <C-\>e
    silent! unmap <C-\>f
    silent! unmap <C-\>i
    if has("menu")  " would rather see if the menu exists, then remove...
      silent! nunmenu Cscope
    endif
  endif
endfunc
"
"==
" Unload_csdb
"  drop cscope connections.
function s:Unload_csdb()
  if exists("b:csdbpath")
    if cscope_connection(3, "out", b:csdbpath)
      set nocscopeverbose
      exe "cs kill " . b:csdbpath
      set cscopeverbose
    endif
  endif
endfunc
"
"==
" Cycle_csdb
"  cycle the loaded cscope db.
function s:Cycle_csdb()
    if exists("b:csdbpath")
      if cscope_connection(3, "out", b:csdbpath)
        return
        "it is already loaded. don't try to reload it.
      endif
    endif
    let newcsdbpath = s:Find_in_parent("cscope.out",s:windowdir(),$HOME)
"    echo "Found cscope.out at: " . newcsdbpath
"    echo "Windowdir: " . s:windowdir()
    if newcsdbpath != "Nothing"
      let b:csdbpath = newcsdbpath
      if !cscope_connection(3, "out", b:csdbpath)
        set nocscopeverbose
        exe "cs add " . b:csdbpath . "/cscope.out " . b:csdbpath
        set cscopeverbose
      endif
      "
    else " No cscope database, undo things. (someone rm-ed it or somesuch)
      call s:Unload_csdb()
    endif
endfunc

" auto toggle the menu
augroup autoload_cscope
 au!
   au BufEnter *.[chC]  call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()
   au BufEnter *.hpp      call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()
   au BufEnter *.cc      call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()
   au BufEnter *.cpp      call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()
   au BufEnter *.cxx      call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()

   au BufUnload *.[chC] call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
   au BufUnload *.hpp     call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
   au BufUnload *.cc     call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
   au BufUnload *.cpp     call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
   au BufUnload *.cxx     call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
augroup END

let &cpo = s:save_cpo
