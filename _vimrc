" Vim with some enhancements
source $VIMRUNTIME/defaults.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Mouse behavior (the Windows way)
behave mswin

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"常规设置
set guifont=JetBrains\ Mono\ Regular:h13
"设置行号 
set number 
"语法高亮
syntax on
"按F2进入粘贴模式
set pastetoggle=<F2>
"高亮搜索
set hlsearch
"设置折叠方式
set foldmethod=indent

"按键设置
let mapleader=','
inoremap <leader>w <Esc>:w<cr>
inoremap jj <Esc>
"窗口移动
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"编码
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set ts=4  
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent 

"vim-plug 插件管理
"使用 :echo &rtp 命令获得vimfiles 路径
call plug#begin('D:\Vim\vimfiles\pluged')
Plug 'mhinz/vim-startify' " 启动界面
Plug 'w0ng/vim-hybrid' "vim-hybrid 主题
Plug 'vim-airline/vim-airline' "状态栏
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline' "代码缩进线 
Plug 'scrooloose/nerdtree' "目录树
Plug 'ctrlpvim/ctrlp.vim' "支持模糊搜索
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround' "成对编辑
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim' "批量替换字符
Plug 'fatih/vim-go'
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

"copy form: https://github.com/evandrocoan/dotfiles/blob/master/.vimrc
 if v:version >= 800
      let s:pythonexecutable = "notinstalled"

      if executable("python")
        let s:pythonexecutable = "python"
      endif

      if executable("python3")
        let s:pythonexecutable = "python3"
      endif

      " https://vi.stackexchange.com/questions/9606/vim-compiled-with-python3-but-haspython-returns-0
      if s:pythonexecutable != 'notinstalled'
        let s:ispython3supported = system( s:pythonexecutable .
            \ ' -c "import sys; sys.stdout.write(
            \    str( int( sys.version_info[0] > 2 and sys.version_info[1] > 5 ) )
            \    )"' )
        if s:ispython3supported == '1' && has('python3')
          if has('nvim')
            Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
          else
            Plug 'Shougo/deoplete.nvim'
            Plug 'roxma/nvim-yarp'
            Plug 'roxma/vim-hug-neovim-rpc'
          endif
        endif
      endif
    endif

Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary' "代码注释
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'lervag/vimtex'
call plug#end()

" fix deoplete.nvim error(Calling wrong python3 interpreter under Cygwin) 
if has('win32unix')
  if executable("python3.9")
    let g:python3_host_prog = 'python3.9'
    let &pythonthreedll = 'python39.lib'
  endif
endif
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

"设置主题
colorscheme hybrid

"查找文件在目录树中的位置
nnoremap <leader>v :NERDTreeFind<cr>
"打开NERDTree
nnoremap <leader>g :NERDTreeToggle<cr>
let NERDTreeShowHidden=1
let NERDTreeIgnore = [
    \ '\.git$', '\.hg$', '\.svn$', '\.swp$',
    \ '\.pyc$',
    \]

"
let g:ctrlp_map = '<c-p>'

"
nmap <leader>s <Plug>(easymotion-s2)

"vim-go  
"wiki: https://github.com/fatih/vim-go/wiki/Tutorial
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

if has('win32unix')
  if executable("python3.9")
    let g:python3_host_prog = 'C:\Users\gog\AppData\Local\Programs\Python\Python39\python.exe'
    let &pythonthreedll = 'C:\Users\gog\AppData\Local\Programs\Python\Python39\libs\python39.lib'
  endif
endif
let g:deoplete#enable_at_startup=1

set updatetime=100 "100毫秒

" vimtex config 
let g:tex_flavor='latex'

" 阅读器相关的配置 包含正反向查找功能 仅供参考
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
\ = '-reuse-instance -forward-search @tex @line @pdf'
\ . ' -inverse-search "' . exepath(v:progpath)
\ . ' --servername ' . v:servername
\ . ' --remote-send \"^<C-\^>^<C-n^>'
\ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
\ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
\ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'

set conceallevel=1
let g:tex_conceal='abdmg'
