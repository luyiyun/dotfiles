"#######################################################################################
" #####  ####   ####  #         ###### #    # #    #  ####  ##### #  ####  #    #  ####
"   #   #    # #    # #         #      #    # ##   # #    #   #   # #    # ##   # #
"   #   #    # #    # #         #####  #    # # #  # #        #   # #    # # #  #  ####
"   #   #    # #    # #         #      #    # #  # # #        #   # #    # #  # #      #
"   #   #    # #    # #         #      #    # #   ## #    #   #   # #    # #   ## #    #
"   #    ####   ####  ######    #       ####  #    #  ####    #   #  ####  #    #  ####
"#######################################################################################

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │  打开当前行的url                                                             │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! OpenCurrentLineURL()
  let l:uri = matchstr(getline('.'), 'https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*')
  if l:uri != ''
    let l:uri = substitute(l:uri, '#', '\\\#', '')
    let l:uri = substitute(l:uri, '%', '\\\%', '')
    let l:uri = substitute(l:uri, '?', '\\\?', '')
    let l:uri = substitute(l:uri, '&', '\\\&', '')
    let l:cmdstr = '!open -u ' . l:uri
    silent execute l:cmdstr
  else
    echo 'Not found url in current line'
  endif
endfunction

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │ 在浏览器中打开当前文件                                                       │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! OpenFileWithGoogleChrome()
  let l:filepath = expand('%:p')
  if l:filepath != ''
    let l:appname  = 'Google\ Chrome.app' " Google\ Chrome.app | Firefox.app | Safari.app
    let l:cmdstr = '!open -a '. l:appname .' --url=file://' . l:filepath
    silent execute l:cmdstr
  else
    echo 'File not found'
  endif
endfunction

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │  在浏览器中打开url, 并且静默执行不要提示                                     │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! SilentOpenURL(uri)
  let l:cmdstr = '!open --url=' . a:uri
  silent execute l:cmdstr
endfunction

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │  在 github desktop 客户端中打开, 需要安装 github desktop 客户端              │
" │  然后找到菜单: Github Desktop => install command line tool                   │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! OpenInGithubDesktop()
  let l:cmdstr = '!github open ' . getcwd()
  silent execute l:cmdstr
endfunction

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │ 将当前项目在vscode中打开                                                     │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! OpenInVisualStudioCode()
  let l:cmdstr = '!code ' . getcwd()
  silent execute l:cmdstr
endfunction

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │ 静默打开App                                                                  │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! SilentOpenApp(app)
  let l:cmdstr = '!open -a ' . a:app
  silent execute l:cmdstr
endfunction

" ╭──────────────────────────────────────────────────────────────────────────────╮
" │ 复制配置文件目录下的 editorconfig 文件                                       │
" ╰──────────────────────────────────────────────────────────────────────────────╯
function! EditorConfigGenerator()
  " cp /Users/xxx/.nvim/config/.editorconfig /Users/xxx/to/path
  let l:cmdstr = '!cp ' . stdpath('config') . '/.editorconfig ' . getcwd()
  silent execute l:cmdstr
endfunction

