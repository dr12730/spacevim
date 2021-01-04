"======================================================================
"
" init-keymaps.vim - 按键设置，按你喜欢更改
"
"   - 快速移动
"   - 标签切换
"   - 窗口切换
"   - 终端支持
"   - 编译运行
"   - 符号搜索
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 17:59:31
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" 基本映射
"----------------------------------------------------------------------
let mapleader=" "
noremap <LEADER>s :Startify<CR>
noremap <leader><cr> :nohls<cr>
" 跳转到上一次修改处
nnoremap <silent> g; g;zz
" 跳转到下一次修改
nnoremap <silent> g, g,zz
" 创建窗口
noremap sj :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sk :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
" 左右调整窗口大小，上下调整：<C-w>+, <C-w>-
nmap <C-w>[ :vertical resize -3<CR>
nmap <C-w>] :vertical resize +3<CR>
"delete buffer
nnoremap <C-x>  :bd<CR>
" 使用 <space>ha 清除 errormarker 标注的错误
noremap <silent><space>ha :removeerrormarkers<cr>

"----------------------------------------------------------------------
" 设置 CTRL+HJKL 移动光标（INSERT 模式偶尔需要移动的方便些）
" 使用 SecureCRT/XShell 等终端软件需设置：Backspace sends delete
" 详见：http://www.skywind.me/blog/archives/2021
"----------------------------------------------------------------------
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <C-o> <esc>o

"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-f> <c-d>
cnoremap <c-b> <left>
cnoremap <c-d> <del>

"----------------------------------------------------------------------
" TAB：创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"----------------------------------------------------------------------
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>tx :tabclose<cr>
noremap <silent> <leader>tf :tabnext<cr>
noremap <silent> <leader>tb :tabprev<cr>
noremap <silent> <leader>to :tabonly<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            easymotion 配置                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" s{char}{char} to move to {char}{char}
nmap s <plug>(easymotion-overwin-f2)

" move to word
nmap <leader><leader>w <plug>(easymotion-overwin-w)

" gif config
map  / <plug>(easymotion-sn)
omap / <plug>(easymotion-tn)

let g:easymotion_startofline = 0 " keep cursor column when jk motion
let g:easymotion_smartcase = 1

"----------------------------------------------------------------------
" 各插件的快捷键设置
"----------------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            startify 配置                                "
" 					展示开始画面，显示最近编辑过的文件					  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change
let g:startify_padding_left = 30
" 默认不显示 startify
let g:startify_disable_at_vimenter = 1
let g:startify_session_dir = '~/.vim/session'

let s:header = [
	\ '',
	\ '   __         _    _        _    _      _         _    ',
	\ '  / /    ___ | |_ ( ) ___  | |_ | |__  (_) _ __  | | __',
	\ ' / /    / _ \| __||/ / __| | __|| |_ \ | || |_ \ | |/ /',
	\ '/ /___ |  __/| |_    \__ \ | |_ | | | || || | | ||   < ',
	\ '\____/  \___| \__|   |___/  \__||_| |_||_||_| |_||_|\_\',
	\ '                                                       ',
	\ '             [ thinkvim   author: rayn miller ]        ',
	\ '',
	\ ]

let s:footer = [
	\ '+-------------------------------------------+',
	\ '|            thinkvim ^_^                   |',
	\ '|    talk is cheap show me the code         |',
	\ '|                                           |',
	\ '|            github:dr12730                 |',
	\ '+-------------------------------------------+',
	\ ]

function! s:center(lines) abort
let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
let centered_lines = map(copy(a:lines),
		\ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)
let g:startify_custom_footer = s:center(s:footer)

" 默认不显示 startify
let g:startify_disable_at_vimenter = 1
let g:startify_session_dir = '~/.vim/session'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-preview 配置                              "
" 			提供基于 tags 的定义预览，函数参数预览，quickfix 预览         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap gj :PreviewTag<cr>
noremap gk :PreviewClose<cr>
let g:preview#preview_position="below"
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
" use <m-u> and <m-d> directly to scroll preview window, <m-u>=<alt-u>
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
"preview the function signature
noremap gh :PreviewSignature!<cr>
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-table 配置                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>tm :tablemodetoggle<cr>
let g:table_mode_corner='|'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        markdown-preview 配置                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <c-p> <plug>markdownpreviewtoggle


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          	   tagbar 配置                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>gg :TagbarToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             NERDtree 配置                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0

" open nerdtree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"if the only window left open is a nerdtree close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

noremap <space>no :NERDTreeFocus<cr>
noremap <space>nm :NERDTreeMirror<cr>
noremap tt :NERDTreeToggle<cr>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

let g:NERDTreeGitStatusIndicatorMapCustom= {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" 如果没有指定文件，在vim启动时自动打开NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'e:'
let airline#extensions#coc#warning_symbol = 'w:'
let airline#extensions#coc#stl_format_err = '%e{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%w{[%w(#%fw)]}'
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_exclude_preview = 1
let g:airline_section_b = '%n'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#csv#enabled = 0
let g:airline#extensions#vimagit#enabled = 0

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


"----------------------------------------------------------------------
" leaderf：ctrlp / fzf 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
" 打开文件模糊匹配
let g:Lf_ShortcutF = "<Leader>ff"
" 启用弹出窗口模式
let g:Lf_WindowPosition = 'popup'
" 在弹出窗口中预览结果
let g:Lf_PreviewInPopup = 1
" 显示图标，需要 nerdfonts
let g:Lf_ShowDevIcons = 1


" 设置项目根目录标记
let g:Lf_RootMarkers = ['.git', '.root', '.hg', '.svn', '.project']

" 最大历史文件保存 2048 个
let g:Lf_MruMaxFiles = 2048

" ui 定制
"let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')

" 显示绝对路径
let g:Lf_ShowRelativePath = 0

" 隐藏帮助
let g:Lf_HideHelp = 1

" 模糊匹配忽略扩展名
let g:Lf_WildIgnore = {
			\ 'dir': ['.svn','.git','.hg'],
			\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
			\ }

" MRU 文件忽略扩展名
let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_StlColorscheme = 'powerline'

" 禁用 function/buftag 的预览功能，可以手动用 p 预览
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" 使用 ESC 键可以直接退出 LeaderF 的 normal 模式
let g:Lf_NormalMap = {
		\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
		\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
		\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
		\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
		\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
		\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
		\ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        LeaderF rg 配置                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 在光标下搜索词条时，将该模式视为regex，直接进入正常模式
noremap <leader>rw :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>
noremap <leader>rf :<C-U><C-R>=printf("Leaderf! rg -e ")<CR>

" 将结果附加到之前的搜索结果中
noremap <leader>ra :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR><CR>

" 在所有列出的缓冲区中按字面意思搜索光标下的文字
noremap <Leader>rc :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR><CR>

" 回顾上一次搜索。如果结果窗口已关闭，重新打开
noremap <Leader>rh :<C-U>Leaderf! rg --recall<CR><CR>

" 在*.h和*.cpp文件中搜索光标下的单词
noremap <Leader>rs :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.{h,c,cpp}", expand("<cword>"))<CR><CR>

" search word under cursor in cpp and java files.
noremap <Leader>rj :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t java", expand("<cword>"))<CR><CR>

" 在cpp文件中搜索光标下的单词，排除*.hpp文件
noremap <Leader>re :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t c -g !*.hpp", expand("<cword>"))<CR><CR>

" 打开最近使用的文件 MRU，进行模糊匹配
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" 手动生成 gtags 
" Leaderf gtags --update
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>gr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>gd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>go :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>gl :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>gh :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
noremap <leader>gu :<C-U><C-R>=printf("Leaderf gtags --update")<CR><CR>
" ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
noremap <leader>lf :LeaderfFunction!<cr>
" ALT+SHIFT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
noremap <leader>lb :LeaderfBufTag!<cr>
" ALT+n 打开 buffer 列表进行模糊匹配
noremap <leader>fb :LeaderfBuffer<cr>
" ALT+m 全局 tags 模糊匹配
noremap <leader>lt :LeaderfTag<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              coc 配置                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:coc_global_extensions = ['']

" if hidden is not set, textedit might fail.
set hidden
" some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" you will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif
"
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Mappings for CoCList
" 显示所有诊断信息
nnoremap <silent><nowait> <space>ca  :<C-u>CocList diagnostics<cr>
" 管理扩展插件
nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
" 显示所有命令
nnoremap <silent><nowait> <space>cm  :<C-u>CocList commands<cr>
" 查找当前文件的符号
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
" 搜索工作区符号
nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>
" 做下一个项目的默认动作
nnoremap <silent><nowait> <space>cj  :<C-u>CocNext<CR>
" 做前一个项目的默认动作
nnoremap <silent><nowait> <space>ck  :<C-u>CocPrev<CR>
" 恢复最新的 coc 名单
nnoremap <silent><nowait> <space>cp  :<C-u>CocListResume<CR>

" 使用重构功能
" <Plug>(coc-refactor)

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

"set statusline+=%{StatusDiagnostic()}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" json文件正确的高亮
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd filetype json syntax match comment +\/\/.\+$+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 在命令行使用 C 来打开 coc config 文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Setupcommandabbrs(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call Setupcommandabbrs('C', 'CocConfig')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-snippets <c-y> 展开片段
" 自定义的片段路径：$VIMCONFIG/coc/ultisnips
" 使用：:CocCommand snippets.editSnippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1.执行命令 :coclist, 然后使用 <cr> 打开选中列表。
" 2.执行命令 :coclist, 输入 <space>, 输入 <tab> 补全列表名称和列表选项。
" 3.绑定快捷键方式执行 :coclist 命令，例如：


" 打开多光标特性的高亮显示
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
" 选择多个相同词
nmap <silent> <C-d> <Plug>(coc-cursors-word)*
xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call Cocaction('dohover')
	endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-marketplace 使用方法
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. :coclist marketplace - list all available extensions
" 2. :coclist marketplace python - to search extension that name contains python
" 3. √ means installed already, with an uninstall action
" 4. x means uninstalled, with an install action
" 5. * is published by @chemzqm, imo, is official
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-translator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" popup
nmap <Leader>i <Plug>(coc-translator-p)
vmap <Leader>i <Plug>(coc-translator-pv)
" echo
nmap <Leader>e <Plug>(coc-translator-e)
vmap <Leader>e <Plug>(coc-translator-ev)
" replace
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)

" 使用 <space>ha 清除 errormarker 标注的错误
noremap <silent><space>ha :RemoveErrorMarkers<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-cpp 配置                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"highlighting of class scope
"let g:cpp_class_scope_highlight = 1
" highlighting of member variables
"let g:cpp_member_variable_highlight = 1
" highlighting of class names in declarations
"let g:cpp_class_decl_highlight = 1
" highlighting of posix functions
"let g:cpp_posix_standard = 1
" highlight template functions, 
" works in most cases, but can be a little slow on large files
"let g:cpp_experimental_simple_template_highlight = 1

" highlighting of library concepts
"let g:cpp_concepts_highlight = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        gutentags 配置                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $GTAGSLABEL = 'native-pygments'

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0



"----------------------------------------------------------------------
" 编译运行 C/C++ 项目
" 详细见：http://www.skywind.me/blog/archives/2084
"----------------------------------------------------------------------

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        vimspector 配置                                "
"                        用于调试
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

" 使用 vimspector 的配置
let g:vimspector_enable_mappings='HUMAN'

nmap <a-j> <Plug>VimspectorStepOver
nmap <a-l> <Plug>VimspectorStepInto
nmap <a-h> <Plug>VimspectorStepOut
nmap <a-k> <Plug>VimspectorContinue
nmap <a-o> <Plug>VimspectorToggleBreakpoint
nmap <a-s> <Plug>VimspectorStop


sign define vimspectorBP text=❄  texthl=Normal
sign define vimspectorBPDisabled text=❆ texthl=Normal
sign define vimspectorPC text=➤ texthl=SpellBad

nmap <silent> w <Plug>(coc-ci-w)
nmap <silent> b <Plug>(coc-ci-b)
