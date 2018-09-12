# StatuslineUpdateTimer : vim statusline periodic update plugin

## attached
- Generic clock function - Common usage:statusline clock

## Usage

### Option variable

```vim
g:StatuslineUpdateTimer#enable
```

Plugin enable/disable.
Set as before plugin load.

```vim
g:StatuslineUpdateTimer#updatetime
```

Statusline update interval.
Set as before plugin load.

default value: same as `updatetime`.

```vim
g:StatuslineUpdateTimer#clockformat
```

Clock function format(strftime style).

default value: `'%m/%d(%a) %H:%M'`.

### Function
```vim
g:StatuslineUpdateTimer#clock()
```

Return formatted clock string.

#### case 1. statusline direct setting
Write to `.vimrc`.

```vim
set statusline=%{g:StatuslineUpdateTimer#clock()}
```

#### case 2. lightline at dein
When use [dein](https://github.com/Shougo/dein.vim) plugin manager and [lightline](https://github.com/itchyny/lightline.vim) plugin,
write to `dein.toml`.

```toml
[[plugins]]
repo = 'itchyny/lightline.vim'
depends = ['StatuslineUpateTimer.vim']
hook_add = '''
  let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'readonly', 'filename', 'modified' ]
      \   ],
      \   'right': [
      \     ['clock'],
      \     ['lineinfo', 'percent'],
      \     ['fileformat', 'fileencoding', 'filetype'],
      \   ]
      \ },
      \ 'component_function': {
      \   'clock': 'LightlineClock',
      \ },
      \ }

  function! LightlineClock()
    return g:StatuslineUpdateTimer#clock()
  endfunction
'''
```

## Limitation

Buffer refreshed by timer.
As a result, opening splash-string disappears.

## Author
- Tsuyoshi CHO (https://github.com/tsuyoshicho)

## License
This software is released under the MIT License, see LICENSE.
