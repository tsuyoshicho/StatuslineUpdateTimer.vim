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

" Timer ID
let g:StatuslineUpdateTimer#timerhandler = v:null

" timer core function
function! g:StatuslineUpdateTimer#timer(timer) abort
  redrawstatus!

  " restart timer : new interval time
  let g:StatuslineUpdateTimer#timerhandler = timer_start(g:StatuslineUpdateTimer#getNextInterval(), function("StatuslineUpdateTimer#timer"))
endfunction

function! s:start() abort
  if has('timers') && (v:null == g:StatuslineUpdateTimer#timerhandler)
    call StatuslineUpdateTimer#timer(g:StatuslineUpdateTimer#timerhandler)
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

if has('timers') && g:StatuslineUpdateTimer#enable
  call StatuslineUpdateTimer#timer(g:StatuslineUpdateTimer#timerhandler)
endif

let &cpo = s:save_cpo
unlet s:save_cpo

