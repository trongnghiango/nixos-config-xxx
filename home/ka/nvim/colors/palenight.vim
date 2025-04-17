" Vim Color File
" Name:       palenight.vim
" Maintainer: https://github.com/drewtempelmeyer/palenight.vim
" License:    MIT
" Based On:   https://github.com/joshdick/onedark.vim

" Initialization {{{
highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256
let g:colors_name="palenight"

if !exists("g:palenight_termcolors")
  let g:palenight_termcolors = 256
endif

if !exists("g:palenight_terminal_italics")
  let g:palenight_terminal_italics = 0
endif

function! s:h(group, style)
  if g:palenight_terminal_italics == 0
    if has_key(a:style, "cterm") && a:style["cterm"] == "italic"
      unlet a:style.cterm
    endif
    if has_key(a:style, "gui") && a:style["gui"] == "italic"
      unlet a:style.gui
    endif
  endif
  if g:palenight_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  endif
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

function! palenight#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction
" }}}

" Color Variables {{{
function! palenight#GetColors()
  return {
    \ 'red':         { 'gui': '#ff5370', 'cterm': '204', 'cterm16': '1' },
    \ 'light_red':   { 'gui': '#ff869a', 'cterm': '204', 'cterm16': '9' },
    \ 'dark_red':    { 'gui': '#be5046', 'cterm': '196', 'cterm16': '9' },
    \ 'green':       { 'gui': '#c3e88d', 'cterm': '114', 'cterm16': '2' },
    \ 'yellow':      { 'gui': '#ffcb6b', 'cterm': '221', 'cterm16': '3' },
    \ 'dark_yellow': { 'gui': '#f78c6c', 'cterm': '173', 'cterm16': '11' },
    \ 'blue':        { 'gui': '#82b1ff', 'cterm': '39',  'cterm16': '4' },
    \ 'purple':      { 'gui': '#c792ea', 'cterm': '170', 'cterm16': '5' },
    \ 'blue_purple': { 'gui': '#939ede', 'cterm': '39',  'cterm16': '13' },
    \ 'cyan':        { 'gui': '#89ddff', 'cterm': '38',  'cterm16': '6' },
    \ 'white':       { 'gui': '#bfc7d5', 'cterm': '145', 'cterm16': '15' },
    \ 'black':       { 'gui': '#292d3e', 'cterm': '235', 'cterm16': '0' },
    \ 'visual_black':{ 'gui': '#000000', 'cterm': '0',   'cterm16': '0' },
    \ 'comment_grey':{ 'gui': '#697098', 'cterm': '59',  'cterm16': '8' },
    \ 'gutter_fg_grey': { 'gui': '#4b5263', 'cterm': '238', 'cterm16': '8' },
    \ 'cursor_grey': { 'gui': '#2c323c', 'cterm': '236', 'cterm16': '8' },
    \ 'visual_grey': { 'gui': '#3e4452', 'cterm': '237', 'cterm16': '8' },
    \ 'menu_grey':   { 'gui': '#3e4452', 'cterm': '237', 'cterm16': '8' },
    \ 'special_grey':{ 'gui': '#3b4048', 'cterm': '238', 'cterm16': '8' },
    \ 'vertsplit':   { 'gui': '#181a1f', 'cterm': '59',  'cterm16': '8' },
    \ 'white_mask_3':{ 'gui': '#ffffff', 'cterm': '15',  'cterm16': '15' }}
endfunction

let s:colors = palenight#GetColors()
let s:red = s:colors.red
let s:light_red = s:colors.light_red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:dark_yellow = s:colors.dark_yellow
let s:blue = s:colors.blue
let s:purple = s:colors.purple
let s:blue_purple = s:colors.blue_purple
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:black = s:colors.black
let s:visual_black = s:colors.visual_black
let s:comment_grey = s:colors.comment_grey
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit
let s:white_mask_3 = s:colors.white_mask_3
" }}}

" Syntax Groups {{{
call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" })
call s:h("Constant", { "fg": s:cyan })
call s:h("String", { "fg": s:green })
call s:h("Character", { "fg": s:green })
call s:h("Number", { "fg": s:dark_yellow })
call s:h("Boolean", { "fg": s:red })
call s:h("Float", { "fg": s:dark_yellow })
call s:h("Identifier", { "fg": s:red })
call s:h("Function", { "fg": s:blue })
call s:h("Statement", { "fg": s:purple })
call s:h("Conditional", { "fg": s:purple })
call s:h("Repeat", { "fg": s:purple })
call s:h("Label", { "fg": s:purple })
call s:h("Operator", { "fg": s:cyan })
call s:h("Keyword", { "fg": s:red })
call s:h("Exception", { "fg": s:purple })
call s:h("PreProc", { "fg": s:yellow })
call s:h("Include", { "fg": s:blue })
call s:h("Define", { "fg": s:purple })
call s:h("Macro", { "fg": s:purple })
call s:h("PreCondit", { "fg": s:yellow })
call s:h("Type", { "fg": s:yellow })
call s:h("StorageClass", { "fg": s:yellow })
call s:h("Structure", { "fg": s:yellow })
call s:h("Typedef", { "fg": s:yellow })
call s:h("Special", { "fg": s:blue })
call s:h("SpecialChar", {})
call s:h("Tag", {})
call s:h("Delimiter", {})
call s:h("SpecialComment", { "fg": s:comment_grey })
call s:h("Debug", {})
call s:h("Underlined", { "gui": "underline", "cterm": "underline" })
call s:h("Ignore", {})
call s:h("Error", { "fg": s:red })
call s:h("Todo", { "fg": s:purple })
" }}}

" Highlighting Groups {{{
call s:h("ColorColumn", { "bg": s:cursor_grey })
call s:h("Conceal", {})
call s:h("Cursor", { "fg": s:black, "bg": s:blue })
call s:h("CursorIM", {})
call s:h("CursorColumn", { "bg": s:cursor_grey })
call s:h("CursorLine", { "bg": s:cursor_grey })
call s:h("Directory", { "fg": s:blue })
call s:h("DiffAdd", { "bg": s:green, "fg": s:black })
call s:h("DiffChange", { "bg": s:yellow, "fg": s:black })
call s:h("DiffDelete", { "bg": s:red, "fg": s:black })
call s:h("DiffText", { "bg": s:black, "fg": s:yellow })
call s:h("ErrorMsg", { "fg": s:red })
call s:h("VertSplit", { "fg": s:vertsplit })
call s:h("Folded", { "bg": s:cursor_grey, "fg": s:comment_grey })
call s:h("FoldColumn", {})
call s:h("SignColumn", {})
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey })
call s:h("LineNr", { "fg": s:gutter_fg_grey })
call s:h("CursorLineNr", {})
call s:h("MatchParen", { "fg": s:blue, "gui": "underline" })
call s:h("ModeMsg", {})
call s:h("MoreMsg", {})
call s:h("NonText", { "fg": s:special_grey })
call s:h("Normal", { "fg": s:white, "bg": s:black })
call s:h("Pmenu", { "bg": s:menu_grey })
call s:h("PmenuSel", { "fg": s:black, "bg": s:blue })
call s:h("PmenuSbar", { "bg": s:special_grey })
call s:h("PmenuThumb", { "bg": s:white })
call s:h("Question", { "fg": s:purple })
call s:h("Search", { "fg": s:black, "bg": s:yellow })
call s:h("SpecialKey", { "fg": s:special_grey })
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("SpellCap", { "fg": s:dark_yellow })
call s:h("SpellLocal", { "fg": s:dark_yellow })
call s:h("SpellRare", { "fg": s:dark_yellow })
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey })
call s:h("StatusLineNC", { "fg": s:comment_grey })
call s:h("TabLine", { "fg": s:comment_grey })
call s:h("TabLineFill", {})
call s:h("TabLineSel", { "fg": s:white })
call s:h("Title", { "fg": s:green })
call s:h("Visual", { "fg": s:visual_black, "bg": s:visual_grey })
call s:h("VisualNOS", { "bg": s:visual_grey })
call s:h("WarningMsg", { "fg": s:yellow })
call s:h("WildMenu", { "fg": s:black, "bg": s:blue })
" }}}

" Terminal Colors {{{
if has("nvim")
  let g:terminal_color_0 =  s:black.gui
  let g:terminal_color_1 =  s:red.gui
  let g:terminal_color_2 =  s:green.gui
  let g:terminal_color_3 =  s:yellow.gui
  let g:terminal_color_4 =  s:blue.gui
  let g:terminal_color_5 =  s:purple.gui
  let g:terminal_color_6 =  s:cyan.gui
  let g:terminal_color_7 =  s:white.gui
  let g:terminal_color_8 =  s:visual_grey.gui
  let g:terminal_color_9 =  s:dark_red.gui
  let g:terminal_color_10 = s:green.gui
  let g:terminal_color_11 = s:dark_yellow.gui
  let g:terminal_color_12 = s:blue.gui
  let g:terminal_color_13 = s:purple.gui
  let g:terminal_color_14 = s:cyan.gui
  let g:terminal_color_15 = s:comment_grey.gui
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_7
elseif has('terminal')
  let g:terminal_ansi_colors = [
    \ s:black.gui,
    \ s:red.gui,
    \ s:green.gui,
    \ s:yellow.gui,
    \ s:blue.gui,
    \ s:purple.gui,
    \ s:cyan.gui,
    \ s:white.gui,
    \ s:visual_grey.gui,
    \ s:dark_red.gui,
    \ s:green.gui,
    \ s:dark_yellow.gui,
    \ s:blue.gui,
    \ s:purple.gui,
    \ s:cyan.gui,
    \ s:white.gui
    \ ]
endif
" }}}

set background=dark
