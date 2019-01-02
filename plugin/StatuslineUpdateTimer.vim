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

" update for adjust minute : default false
" if enabled; updatetime are no affect
let g:StatuslineUpdateTimer#adjust_minute = get(g:, 'StatuslineUpdateTimer#adjust_minute', 0)

" timer core function
function! g:StatuslineUpdateTimer#timer(timer) abort
  redrawstatus!

  " restart timer : new interval time
  let g:StatuslineUpdateTimer#timerhandler = timer_start(g:StatuslineUpdateTimer#getInterval(), function("StatuslineUpdateTimer#timer"))
endfunction

" timer interval function
function! g:StatuslineUpdateTimer#getInterval() abort
  let interval = g:StatuslineUpdateTimer#updatetime

  " adjust next updatetime : next min 01 sec point
  if g:StatuslineUpdateTimer#adjust_minute
    let now = localtime()
    " next updatetime = 1min(60sec) - current sec(ex 1min 25sec = 25sec) + 1 -> msec
    let interval = (60 - (now % 60) + 1) * 1000
  endif

  " debug
  " echom 'update time:'.interval . ' now:'.strftime('%X') . ' flag:'.g:StatuslineUpdateTimer#adjust_minute

  return interval
endfunction

if has('timers') && g:StatuslineUpdateTimer#enable
  let g:StatuslineUpdateTimer#timerhandler = timer_start(g:StatuslineUpdateTimer#getInterval(), function("StatuslineUpdateTimer#timer"))
endif

let &cpo = s:save_cpo
unlet s:save_cpo

