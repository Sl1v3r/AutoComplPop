


" LOAD GUARD: ================================================================


if exists('g:loaded_acp')
  finish
elseif v:version < 702
  echoerr 'AutoComplPop does not support this version of vim (' . v:version . ').'
  finish
endif
let g:loaded_acp = 1



" FUNCTION: ==================================================================


function s:defineOption(name, default)
  if !exists(a:name)
    let {a:name} = a:default
  endif
endfunction

"
function s:makeDefaultBehavior()

  let behavs = {
        \   '*'          : [],
        \   'ruby'       : [],
        \   'python'     : [],
        \   'javascript' : [],
        \   'perl'       : [],
        \   'xml'        : [],
        \   'php'        : [],
        \   'html'       : [],
        \   'jade'       : [],
        \   'xhtml'      : [],
        \   'css'        : [],
        \   'scss'       : [],
        \   'sass'       : [],
        \   'less'       : [],
        \   'haskell'    : [],
        \ }

  if !empty(g:acp_behaviorUserDefinedFunction) &&
        \ !empty(g:acp_behaviorUserDefinedMeets)
    for key in keys(behavs)
      call add(behavs[key], {
            \   'command'      : "\<C-x>\<C-u>",
            \   'completefunc' : g:acp_behaviorUserDefinedFunction,
            \   'meets'        : g:acp_behaviorUserDefinedMeets,
            \   'repeat'       : 0,
            \ })
    endfor
  endif


  for key in keys(behavs)
    call add(behavs[key], {
          \   'command'      : "\<C-x>\<C-u>",
          \   'completefunc' : 'acp#completeSnipmate',
          \   'meets'        : 'acp#meetsForSnipmate',
          \   'onPopupClose' : 'acp#onPopupCloseSnipmate',
          \   'repeat'       : 0,
          \ })
  endfor

  for key in keys(behavs)
    call add(behavs[key], {
          \   'command' : g:acp_behaviorKeywordCommand,
          \   'meets'   : 'acp#meetsForKeyword',
          \   'repeat'  : 0,
          \ })
  endfor

  for key in keys(behavs)
    call add(behavs[key], {
          \   'command' : "\<C-x>\<C-f>",
          \   'meets'   : 'acp#meetsForFile',
          \   'repeat'  : 1,
          \ })
  endfor


  call add(behavs.ruby, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForRubyOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.python, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForPythonOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.javascript, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForJavascriptOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.haskell, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForHaskellOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.perl, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForPerlOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.xml, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForXmlOmni',
        \   'repeat'  : 1,
        \ })

  call add(behavs.html, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForHtmlOmni',
        \   'repeat'  : 1,
        \ })

  call add(behavs.php, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForPhpOmni',
        \   'repeat'  : 1,
        \ })

  call add(behavs.xhtml, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForHtmlOmni',
        \   'repeat'  : 1,
        \ })

  call add(behavs.jade, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForJadeOmni',
        \   'repeat'  : 1,
        \ })

  call add(behavs.css, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForCssOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.sass, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForSassOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.scss, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForScssOmni',
        \   'repeat'  : 0,
        \ })

  call add(behavs.less, {
        \   'command' : "\<C-x>\<C-o>",
        \   'meets'   : 'acp#meetsForLessOmni',
        \   'repeat'  : 0,
        \ })

  return behavs

endfunction



" INITIALIZATION: ============================================================


call s:defineOption('g:acp_enableAtStartup', 1)
call s:defineOption('g:acp_mappingDriven', 0)
call s:defineOption('g:acp_ignorecaseOption', 1)
call s:defineOption('g:acp_completeOption', '.,w,b,k')
call s:defineOption('g:acp_completeoptPreview', 0)
call s:defineOption('g:acp_behaviorUserDefinedFunction', '')
call s:defineOption('g:acp_behaviorUserDefinedMeets', '')
call s:defineOption('g:acp_behaviorSnipmateLength', -1)
call s:defineOption('g:acp_behaviorKeywordCommand', "\<C-n>")
call s:defineOption('g:acp_behaviorKeywordLength', 2)
call s:defineOption('g:acp_behaviorKeywordIgnores', [])
call s:defineOption('g:acp_behaviorFileLength', 0)
call s:defineOption('g:acp_behaviorRubyOmniMethodLength', 0)
call s:defineOption('g:acp_behaviorRubyOmniSymbolLength', 1)
call s:defineOption('g:acp_behaviorPythonOmniLength', 0)
call s:defineOption('g:acp_behaviorJavascriptOmniLength', 0)
call s:defineOption('g:acp_behaviorHaskellOmniLength', 0)
call s:defineOption('g:acp_behaviorPerlOmniLength', -1)
call s:defineOption('g:acp_behaviorXmlOmniLength', 0)
call s:defineOption('g:acp_behaviorPhpOmniLength', 1)
call s:defineOption('g:acp_behaviorHtmlOmniLength', 1)
call s:defineOption('g:acp_behaviorJadeOmniLength', 1)
call s:defineOption('g:acp_behaviorCssOmniPropertyLength', 1)
call s:defineOption('g:acp_behaviorCssOmniValueLength', 0)
call s:defineOption('g:acp_behavior', {})

call extend(g:acp_behavior, s:makeDefaultBehavior(), 'keep')

command! -bar -narg=0 AcpEnable  call acp#enable()
command! -bar -narg=0 AcpDisable call acp#disable()

if g:acp_enableAtStartup
  AcpEnable
endif
