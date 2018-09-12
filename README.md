# StatuslineUpateTimer : vim statusline periodic update plugin

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

default value: '%m/%d(%a) %H:%M'.

### Function
```vim
g:StatuslineUpdateTimer#clock()
```

Return formatted clock string.

## Limitation

Buffer refreshed by timer.
As a result, opening splash-string disappears.

## Author
- Tsuyoshi CHO (https://github.com/tsuyoshicho)

## License
This software is released under the MIT License, see LICENSE.
