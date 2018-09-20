" Vim global plugin for Statusline Update Timer
" Last Change: 2018/09/20
" Maintainer: Tsuyoshi CHO <tsuyoshi.cho@gmail.com>
" License: MIT License

if exists("g:loaded_StatuslineUpdateTimer")
  finish
endif
let g:loaded_StatuslineUpdateTimer = 1

let s:save_cpo = &cpo
set cpo&vim

" variable

" update enable : default true
let g:StatuslineUpdateTimer#enable = get(g:, 'StatuslineUpdateTimer#enable', 1)

" update interval : default swapfile updatetime
let g:StatuslineUpdateTimer#updatetime = get(g:, 'StatuslineUpdateTimer#updatetime', &updatetime)

" timer core function
function! g:StatuslineUpdateTimer#timer(timer)
  redrawstatus!
endfunction

if has('timers') && g:StatuslineUpdateTimer#enable
  let g:StatuslineUpdateTimer#timerhandler = timer_start(g:StatuslineUpdateTimer#updatetime, function("StatuslineUpdateTimer#timer"), {'repeat': -1})
endif

let &cpo = s:save_cpo
unlet s:save_cpo

