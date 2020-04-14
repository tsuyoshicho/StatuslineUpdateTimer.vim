" Vim global plugin for Statusline Update Timer
" Last Change: 2018/09/12
" Maintainer: Tsuyoshi CHO <tsuyoshi.cho@gmail.com>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

" variable

" clock format
let g:StatuslineUpdateTimer#clockformat = get(g:, 'StatuslineUpdateTimer#clockformat', '%m/%d(%a) %H:%M')

" generic status clock
function! StatuslineUpdateTimer#clock() abort
  return strftime(g:StatuslineUpdateTimer#clockformat, localtime())
endfunction

let s:emoji_clock = [
  \ '🕛',
  \ '🕐',
  \ '🕑',
  \ '🕒',
  \ '🕓',
  \ '🕔',
  \ '🕕',
  \ '🕖',
  \ '🕗',
  \ '🕘',
  \ '🕙',
  \ '🕚',
  \ ]

" generic status emoji clock
function! StatuslineUpdateTimer#emoji_clock() abort
  return s:emoji_clock[str2nr(strftime('%H', localtime())) % len(s:emoji_clock)]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

