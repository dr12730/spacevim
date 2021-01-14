function! myspacevim#before() abort
  let profile = SpaceVim#mapping#search#getprofile('rg')
  let default_opt = profile.default_opts + ['--no-ignore-vcs']
  call SpaceVim#mapping#search#profile({'rg' : {'default_opts' : default_opt}})

  let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-rls', 'coc-yank', 'coc-snippets', ]
  call SpaceVim#plugins#tasks#reg_provider(function('s:make_tasks'))
  call SpaceVim#plugins#tasks#reg_provider(funcref('s:cargo_task'))

  " GoTo code navigation.
  nmap <silent> <space>gl <Plug>(coc-definition)
  nmap <silent> <space>gt <Plug>(coc-type-definition)
  nmap <silent> <space>gi <Plug>(coc-implementation)
  nmap <silent> <space>gr <Plug>(coc-references)

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

  call Setupcommandabbrs('C', 'CocConfig')
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "                        vimspector 配置                                "
  "                        用于调试
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

  " Debugger remaps
  nnoremap <space>dk :call vimspector#Launch()<CR>
  nnoremap <space>de :call vimspector#Reset()<CR>
  nnoremap <space>dx :call vimspector#CleanLineBreakpoint()<CR>
  nnoremap <space>dc :call vimspector#Continue()<CR>
  nnoremap <space>ds :call vimspector#Stop()<CR>
  nnoremap <space>dl :call vimspector#StepInto()<CR>
  nnoremap <space>dj :call vimspector#StepOver()<CR>
  nnoremap <space>dh :call vimspector#StepOut()<CR>
  nnoremap <space>dr :call vimspector#Restart()<CR>
  nnoremap <space>dd :call vimspector#RunToCursor()<CR>
  nnoremap <space>di :call vimspector#ToggleBreakpoint()<CR>
  nnoremap <space>db :call vimspector#ToggleBreakpoint(
                    \ { 'condition': input( 'Enter condition expression: ' ),
                    \   'hitCondition': input( 'Enter hit count expression: ' ) }
                    \ )<CR>


  sign define vimspectorBP text=❄  texthl=Normal
  sign define vimspectorBPDisabled text=❆ texthl=Normal
  sign define vimspectorPC text=➤ texthl=Normal
  sign define vimspectorBPCond     text=◆ texthl=Normal
  sign define vimspectorPCBP       text=➤  texthl=Normal

endfunction


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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 在命令行使用 C 来打开 coc config 文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Setupcommandabbrs(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
