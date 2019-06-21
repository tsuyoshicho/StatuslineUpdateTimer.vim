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

" Timer

" Timer ID
let s:timerhandler = v:null

" base    base interval time (sec)
" offset  offset time        (sec)
function! s:getPeriodicInterval(base,offset) abort
  let now = localtime()

  let interval = (a:base - (now % a:base) + a:offset)

  return interval
endfunction

" timer interval function(msec)
function! s:getNextInterval() abort
  let interval = g:StatuslineUpdateTimer#updatetime

  " adjust next updatetime : next min 01 sec point
  if g:StatuslineUpdateTimer#adjust_minute
    " next updatetime = 1min(60sec) - current sec(ex 1min 25sec = 25sec) + 1 = 36sec -> msec
    let interval = s:getPeriodicInterval(60,1) * 1000
  endif

  return interval
endfunction

" timer core function
function! s:timer(timer) abort
  redrawstatus!

  " restart timer : new interval time
  let Callback =function("s:timer")
  let s:timerhandler = timer_start(s:getNextInterval(), Callback)
endfunction

if has('timers') && g:StatuslineUpdateTimer#enable
  call s:timer(s:timerhandler)
endif

" Command

function! s:start() abort
  if has('timers') && (v:null == s:timerhandler)
    call s:timer(s:timerhandler)
  endif
endfunction

function! s:stop() abort
  if has('timers') && (v:null != g:StatuslineUpdateTimer#timerhandler)
    call timer_stop(g:StatuslineUpdateTimer#timerhandler)
    let g:StatuslineUpdateTimer#timerhandler = v:null
  endif
endfunction

command! -nargs=0 StatuslineUpdateStart :call <SID>start()
command! -nargs=0 StatuslineUpdateStop  :call <SID>stop()

let &cpo = s:save_cpo
unlet s:save_cpo

