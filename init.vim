" vim帮助文档https://vimcdoc.sourceforge.net/doc/help.html
set ts=4
set expandtab
set shiftwidth=4
set softtabstop=4
set nu
set hlsearch  " 高亮搜索匹配  
set incsearch " 开启实时搜索功能

" colorscheme desert
colorscheme default
set cursorline "高亮显示当前行 
"当前行不需要显示下划线
hi CursorLine cterm=bold

" map <Space> as leader
nnoremap <SPACE> <Nop>
let mapleader=" "

set foldenable " 打开折叠方式
set foldmethod=syntax " syntax:按c/c++语法折叠{}; indent: 按缩进折叠，适用于python
set foldlevelstart=99 " 打开文件时不自动折叠， zc: 折叠代码， zo: 打开折叠的代码

" sudo apt-get install ctags
set tags=tags;  " 在父目录中递归查找tags文件
"set tags+=~/.vim/systags
set tags+=~/.vim/cpp_tags

" sh -c 'curl -kfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" start nvim, then :PlugInstall
call plug#begin('~/.vim/plugged')

"Plug 'Tagbar'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
" sudo apt-get install ack-grep
Plug 'mileszs/ack.vim'

" Leaderf rg, sudo apt install -y ripgrep
" or curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
" sudo dpkg -i ripgrep_11.0.2_amd64.deb
" install the C extension of the fuzzy matching algorithm
" :LeaderfUninstallCExtension
"Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }


"Plug 'Yggdroot/indentLine'

" You need fugitive to see the current git branch
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'       
Plug 'vim-airline/vim-airline-themes' "airline 的主题

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 自动补全: 注意会导致vim卡慢问题
" https://vi.stackexchange.com/questions/82/how-to-get-intelligent-c-auto-completion
"Plug 'xavierd/clang_complete'

" 支持c/c++ STL即标准库关键字高亮
Plug 'octol/vim-cpp-enhanced-highlight'

" https://github.com/ojroques/vim-oscyank
" https://github.com/Eugeny/tabby/issues/7266
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

Plug 'jiangmiao/auto-pairs'
Plug 'ethanhome/darcula'

call plug#end()

"let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
"let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进

" /airline start
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#coc#enabled = 0
let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
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

" clang_complete:
" provide path directly to the library file
"let g:clang_library_path='/usr/lib/llvm-7/lib/libclang-7.so.1'

nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <F5> :!ctags -R<CR>

" Leaderf setting
" \rg 查找光标所在word出现的地方, .gitignore文件里的不会搜索 
"nnoremap <silent> <Leader>rg :Leaderf rg <C-R><C-W><CR>
nnoremap <Leader>fw :Leaderf rg --regexMode -w <Space> 
nnoremap <silent> <Leader>fs :exe 'Leaderf rg --regexMode -w ' . expand('<cword>')<CR>
nnoremap <C-f> :Leaderf rg --regexMode <C-R><C-W><CR>
" 上次搜索结果
noremap <Leader>fr :<C-U>Leaderf! rg --regexMode --recall<CR>
" 文件模糊搜索
nnoremap <silent> <Leader>ff :Leaderf file<CR>
nnoremap <silent> <Leader>m :Leaderf mru<CR>
nnoremap <silent> <Leader>b :Leaderf buffer<CR>

" 在普通模式下显示函数原型
" 用:ptag <tagname> 命令在Preview窗口预览tag定义, 而光标仍然留在原窗口
" 直接在你要查的word上按;键就行
" 关闭Preview窗口, 执行:pc
nnoremap <silent> ; :ptag <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> ' :pc<CR>
" Tab键切换buffer
nnoremap <Tab> :bNext<CR>
" 翻页
nnoremap <Leader>j <PageDown>
nnoremap <Leader>k <PageUp>
" source neovim config file without restarting nvim/vim
" 2021 update: If you are using neovim with a lua config, you can use :luafile $MYVIMRC
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Ack 查找光标所在word出现的地方
" nnoremap <C-f> :Ack<CR>

" clangd coc自动补全按回车选择
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

vnoremap <leader>c :OSCYank<CR>

"colorscheme darcula

"source ~/.config/nvim/coc.vim 
