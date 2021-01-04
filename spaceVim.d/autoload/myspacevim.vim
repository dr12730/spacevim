function! myspacevim#before() abort
  let profile = SpaceVim#mapping#search#getprofile('rg')
  let default_opt = profile.default_opts + ['--no-ignore-vcs']
  call SpaceVim#mapping#search#profile({'rg' : {'default_opts' : default_opt}})



  function! s:make_tasks() abort
    if filereadable('Makefile')
        let subcmd = filter(readfile('Makefile', ''), "v:val=~#'^.PHONY'")
        if !empty(subcmd)
            let commands = split(subcmd[0])[1:]
            let conf = {}
            for cmd in commands
                call extend(conf, {
                            \ cmd : {
                            \ 'command': 'make',
                            \ 'args' : [cmd],
                            \ 'isDetected' : 1,
                            \ 'detectedName' : 'make:'
                            \ }
                            \ })
            endfor
            return conf
        else
            return {}
        endif
    else
        return {}
    endif
  endfunction
  call SpaceVim#plugins#tasks#reg_provider(function('s:make_tasks'))


  function! s:cargo_task() abort
    if filereadable('Cargo.toml')
        let commands = ['build', 'run', 'test']
        let conf = {}
        for cmd in commands
            call extend(conf, {
                        \ cmd : {
                        \ 'command': 'cargo',
                        \ 'args' : [cmd],
                        \ 'isDetected' : 1,
                        \ 'detectedName' : 'cargo:'
                        \ }
                        \ })
        endfor
        return conf
    else
        return {}
    endif
  endfunction
  call SpaceVim#plugins#tasks#reg_provider(funcref('s:cargo_task'))


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
  
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 在命令行使用 C 来打开 coc config 文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Setupcommandabbrs(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call Setupcommandabbrs('C', 'CocConfig')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        vimspector 配置                                "
"                        用于调试
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

" 使用 vimspector 的配置
let g:vimspector_enable_mappings='HUMAN'

" Debugger remaps
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nnoremap <leader>dx :call vimspector#CleanLineBreakpoint()<CR>
nnoremap <leader>df :call vimspector#Continue()<CR>
nnoremap <leader>dl :<plug>VimspectorStepInto
nnoremap <leader>dj :<plug>VimspectorStepOver
nnoremap <leader>dk :<plug>VimspectorStepOut
nnoremap <leader>dr :<plug>VimspectorRestart
nnoremap <leader>dtc :<plug>VimspectorRunToCursor
nnoremap <leader>db :<plug>VimspectorToggleBreakpoint
nnoremap <leader>dbc :<plug>VimspectorToggleConditionalBreakpoint


sign define vimspectorBP text=❄  texthl=Normal
sign define vimspectorBPDisabled text=❆ texthl=Normal
sign define vimspectorPC text=➤ texthl=SpellBad

endfunction
