" Vim global plugin for Statusline Update Timer
" Last Change: 2018/09/20
" Maintainer: Tsuyoshi CHO <tsuyoshi.cho@gmail.com>
" License: MIT License

if exists('g:loaded_StatuslineUpdateTimer') || !has('timers')
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

" timer interval process function
function! s:default_interval_function() abort
  redrawstatus!
endfunction

let g:StatuslineUpdateTimer#interval_function = get(g:, 'StatuslineUpdateTimer#interval_function', function('s:default_interval_function'))

" Timer

" Timer ID
let s:timerhandler = v:null

" base    base interval time (sec)
" offset  offset time        (sec)
function! s:getPeriodicInterval(base, offset) abort
  let now = localtime()

  let interval = (a:base - (now % a:base) + a:offset)

  return interval
endfunction

" timer interval timing function(msec)
function! s:getNextIntervalmsec() abort
  let interval_ms = g:StatuslineUpdateTimer#updatetime

  " adjust next updatetime : next min 01 sec point
  if g:StatuslineUpdateTimer#adjust_minute
    " next updatetime = 1min(60sec) - current sec(ex 1min 25sec = 25sec) + 1 = 36sec -> msec
    let interval_ms = s:getPeriodicInterval(60, 1) * 1000
  endif

  return interval_ms
endfunction

" timer core function
function! s:timer(timer) abort
  if exists('g:StatuslineUpdateTimer#interval_function')
      \ && (type(g:StatuslineUpdateTimer#interval_function) == v:t_func)
    call call(g:StatuslineUpdateTimer#interval_function,[])
  endif

  " restart timer : new interval time
  let s:timerhandler = timer_start(s:getNextIntervalmsec(), function("s:timer"))
endfunction

if g:StatuslineUpdateTimer#enable
  call s:timer(s:timerhandler)
endif

" Command

function! s:start() abort
  if s:timerhandler is? v:null
    call s:timer(s:timerhandler)
  endif
endfunction

function! s:stop() abort
  if s:timerhandler isnot? v:null
    call timer_stop(s:timerhandler)
    let s:timerhandler = v:null
  endif
endfunction

command! -nargs=0 StatuslineUpdateStart :call <SID>start()
command! -nargs=0 StatuslineUpdateStop  :call <SID>stop()

let &cpo = s:save_cpo
unlet s:save_cpo

