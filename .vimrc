" vim帮助文档https://vimcdoc.sourceforge.net/doc/help.html
set ts=4
set expandtab
set shiftwidth=4
set softtabstop=4
set nu
"colorscheme desert
colorscheme default
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
set hlsearch  " 高亮搜索匹配
set incsearch " 开启实时搜索功能
set cursorline "高亮显示当前行
syntax on " vim8需要才会高亮

" 在括号处zf%，创建从当前行起到对应的匹配的括号上去（（），{}，[]，<>等）。
" zd 删除 (delete) 在光标下的折叠。仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效。
" set foldmethod=marker 
" 上述方式会产生文件修改，不适合

set foldenable " 打开折叠方式
set foldmethod=syntax " syntax:按c/c++语法折叠{}; indent: 按缩进折叠，适用于python
set foldlevelstart=99 " 打开文件时不自动折叠， zc: 折叠代码， zo: 打开折叠的代码

" sudo apt-get install ctags
set tags=tags;  " 在父目录中递归查找tags文件
"set tags+=~/.vim/systags
set tags+=~/.vim/cpp_tags

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
" sudo apt-get install ack-grep
Plugin 'mileszs/ack.vim'

" Leaderf rg, sudo apt install -y ripgrep
" or curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
" sudo dpkg -i ripgrep_11.0.2_amd64.deb
" install the C extension of the fuzzy matching algorithm
" :LeaderfInstallCExtension
Plugin 'Yggdroot/LeaderF'

" Plugin 'fatih/vim-go'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'Raimondi/delimitMate'

" Plugin 'itchyny/lightline.vim'

" You need fugitive to see the current git branch
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'ethanhome/darcula'
Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'sheerun/vim-polyglot'

if v:version >= 800
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'jiangmiao/auto-pairs'
"Plugin 'Shougo/echodoc.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"set t_Co=256
"set laststatus=2
" let g:lightline = { 'colorscheme': 'powerline', }


" /airline start
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
let g:airline#extensions#whitespace#enabled = 0
"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1
set laststatus=2  "永远显示状态栏
let g:airline_theme='bubblegum' "选择主题
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffer
"let g:airline#extensions#tabline#left_sep = ' '  "separater
"let g:airline#extensions#tabline#left_alt_sep = '|'  "separater
"let g:airline#extensions#tabline#formatter = 'default'  "formater
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
" /airline end

if v:version >= 800
    " YouCompleteMe config
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_server_python_interpreter='/usr/bin/python3'
    let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
    "let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
	let g:ycm_min_num_identifier_candidate_chars = 2
	let g:ycm_collect_identifiers_from_comments_and_strings = 1
	let g:ycm_complete_in_strings=1
    " disable diagnostic 
    let g:ycm_enable_diagnostic_signs = 0
    let g:ycm_enable_diagnostic_highlighting = 0
    " 触发语义补全，默认只会在'::','.', '->'等时机触发
    let g:ycm_semantic_triggers =  {
                                \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                                \ 'cs,lua,javascript': ['re!\w{2}'],
                                \ }
	" 关闭YCM自动弹出函数原型预览窗口
	set completeopt=menu,menuone
	let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_key_invoke_completion = '<c-z>'

endif 
" cpp vim-cpp-enhanced-highlight
let c_no_curly_error=1

" echodoc setting
"set noshowmode
"let g:echodoc_enable_at_startup = 1

nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <F5> :!ctags -R<CR>

" Leaderf setting
" \rg 查找光标所在word出现的地方 
"nnoremap <silent> <Leader>rg :Leaderf rg <C-R><C-W><CR>
nnoremap <silent> <Leader>rg :exe 'Leaderf rg ' . expand('<cword>')<CR>
nnoremap <C-f> :Leaderf rg <C-R><C-W><CR>

" 文件模糊搜索
nnoremap <silent> <Leader>f :Leaderf file<CR>
nnoremap <silent> <Leader>m :Leaderf mru<CR>
nnoremap <silent> <Leader>b :Leaderf buffer<CR>

" 在普通模式下显示函数原型
" 用:ptag <tagname> 命令在Preview窗口预览tag定义, 而光标仍然留在原窗口
" 直接在你要查的word上按;键就行
" 关闭Preview窗口, 执行:pc
nnoremap <silent> ; :ptag <C-R>=expand("<cword>")<CR><CR>

nnoremap <silent> ] :YcmCompleter GoToDefinition<CR>
" Tab键切换buffer
nnoremap <Tab> :bNext<CR>
" space空格翻页
nnoremap <Space> <PageDown>

" Ack 查找光标所在word出现的地方
" nnoremap <C-f> :Ack<CR>

colorscheme darcula
