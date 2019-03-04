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

" timer interval function(msec)
function! g:StatuslineUpdateTimer#getNextInterval() abort
  let interval = g:StatuslineUpdateTimer#updatetime

  " adjust next updatetime : next min 01 sec point
  if g:StatuslineUpdateTimer#adjust_minute
    " next updatetime = 1min(60sec) - current sec(ex 1min 25sec = 25sec) + 1 = 36sec -> msec
    let interval = s:getPeriodicInterval(60,1) * 1000
  endif

  return interval
endfunction

" base    base interval time (sec)
" offset  offset time        (sec)
function! s:getPeriodicInterval(base,offset) abort
  let now = localtime()

  let interval = (a:base - (now % a:base) + a:offset)

  return interval
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

