" Vim global plugin for Statusline Update Timer
" Last Change: 2018/09/12
" Maintainer: Tsuyoshi CHO <tsuyoshi.cho@gmail.com>
" License: MIT License

if exists("g:autoloaded_StatuslineUpdateTimer")
  finish
endif
let g:autoloaded_StatuslineUpdateTimer = 1

let s:save_cpo = &cpo
set cpo&vim

" variable

" clock format
let g:StatuslineUpdateTimer#clockformat = get(g:, 'StatuslineUpdateTimer#clockformat', '%m/%d(%a) %H:%M')

" generic status clock
function! g:StatuslineUpdateTimer#clock()
  return strftime(g:StatuslineUpdateTimer#clockformat, localtime())
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

