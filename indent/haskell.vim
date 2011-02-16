" Vim indent: haskell
" Version: @@VERSION@@
" Copyright (C) 2008-2010 kana <http://whileimautomaton.net/>
" License: So-called MIT/X license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

" Notation:
" * "#" indicates a whitespace for indentation.
" * "<|>" indicates the cursor position after automatic indentation.
" * "<*>" indicates the cursor position before automatic indentation.

if exists('b:did_indent')
  finish
endif




setlocal autoindent
setlocal indentexpr=GetHaskellIndent()
setlocal indentkeys=!^F,o,O

setlocal expandtab
setlocal softtabstop=2
setlocal shiftwidth=2

let b:undo_indent = 'setlocal '.join([
\   'expandtab<',
\   'indentexpr<',
\   'indentkeys<',
\   'shiftwidth<',
\   'softtabstop<',
\ ])




function! GetHaskellIndent()
  let n0 = v:lnum
  let n1 = v:lnum - 1
  let l0 = getline(n0)
  let l1 = getline(n1)
  let at_new_line_p = (l0 =~# '^\s*$')

  if at_new_line_p
    " Case: 'class' statement
    "   class Monad m where<*>
    "   ##<|>
    if l1 =~# '\v^\s*<class>.*<where>'
      return indent(n1) + &l:shiftwidth
    endif

    " Case: 'instance' statement
    "   instance Eq Foo where<*>
    "   ##<|>
    if l1 =~# '\v^\s*<instance>.*<where>'
      return indent(n1) + &l:shiftwidth
    endif

    " Otherwise: Keep the previous indentation level.
    return -1
  else
    " Otherwise: Keep the previous indentation level.
    return -1
  endif
endfunction




let b:did_indent = 1

" __END__
" vim: foldmethod=marker
