"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :

"----------------------------------------------------------------------
" 默认情况下的分组，可以在前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'enhanced', 'filetypes', 'textobj']
	let g:bundle_group += ['airline', 'nerdtree', 'echodoc']
	let g:bundle_group += ['LeaderF', 'snippets', 'themes', 'cpp', 'coc']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

" 符号对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"                            startify 配置                                "
	" 					展示开始画面，显示最近编辑过的文件					  "
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'mhinz/vim-startify'

    " vim中文
	Plug 'yianwillis/vimcdoc'


	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "                           vim-errormaker                                "
	" 根据 quickfix 中匹配到的编译错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
    " <space>ha: 清除错误
    " qf：在 quickfix 中打开错误行
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'mh21/errormarker.vim'

	" 自动生成 gtags/ctags 数据库
	Plug 'ludovicchabant/vim-gutentags'

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"                           vim-preview 配置                              "
	" 			提供基于 tags 的定义预览，函数参数预览，quickfix 预览         "
    " 			gj：预览窗口显示函数定义
    " 			gk: 关闭预览窗口
    " 			gh: 查看函数签名
    " 			<alt-u/d> 预览上下滚动
    " 			<ctrl-w z> 关闭预览窗口
    "           qf: 在预览窗口中打开 quickfix 中的错误信息
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'skywind3000/vim-preview'

	" Git 支持
	Plug 'tpope/vim-fugitive'

	" 光标下划线
	Plug 'itchyny/vim-cursorword'


	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "                              vim-table 配置                             "
    "                   <leader>tm：打开 markdown table 对齐
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "                        markdown-preview 配置                             "
    "                        <c-p>：打开 markdown 预览
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "                          	   tagbar 配置                                 "
    "                       <leader>gg：打开 tag 大纲
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'majutsushi/tagbar'

endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"                               内置终端插件
    "       <alt-=>：打开内置终端
    "       <alt-shift-h/j/k/l>：窗口移动
    "       drop abc.txt：vim 打开文件 abc.txt
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'skywind3000/vim-terminal-help'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0
	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'xuyuanp/nerdtree-git-plugin'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

endif


"----------------------------------------------------------------------
" leaderf：ctrlp / fzf 的超级代替者，文件模糊匹配，tags/函数名 选择
"   <leader>rw：搜索光标下单词
"   <leader>rf: 手动输入单词
"   <leader>ra :将结果附加到之前的搜索结果中
"   <Leader>rc :在所有列出的缓冲区中按搜索光标下的文字  
"   <Leader>rs :在*.h和*.cpp文件中搜索光标下的单词
"<leader>fb :打开 buffer 
"----------------------------------------------------------------------
if index(g:bundle_group, 'LeaderF') >= 0
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
endif


"----------------------------------------------------------------------
" snippets：代码片段
"----------------------------------------------------------------------
if index(g:bundle_group, 'snippets') >= 0
	Plug 'honza/vim-snippets'
endif

"----------------------------------------------------------------------
" coc：插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'coc') >= 0
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

"----------------------------------------------------------------------
" c/cpp：插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'cpp') >= 0
	Plug 'octol/vim-cpp-enhanced-highlight'
	
	" 使用语言服务器协议提供C/C++/ObjC语义突出显示
	Plug 'jackguo380/vim-lsp-cxx-highlight'

	" 调试插件
	Plug 'puremourning/vimspector'

endif

"----------------------------------------------------------------------
" themes：主题
"----------------------------------------------------------------------
if index(g:bundle_group, 'themes') >= 0

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"                          base16-vim 配置                                "
	"			配合 base16-shell 配色框架，同时切换 shell 和vim 的配色	          "
	"					需要同时安装 base16-shell 和 base16-vim 				"
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'chriskempson/base16-vim'
	if filereadable(expand("~/.vimrc_background"))
		let base16colorspace=256
		source ~/.vimrc_background
	endif
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()
