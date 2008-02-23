; use strict; use warnings
; use Test::More tests => 6

; BEGIN { use_ok('HO::HTML::Input',
                 functional => [qw/IButton Checkbox Hidden Radio Text/]
                )
        }
    
; is("".IButton(),'<input type="button" >')

; is("".Checkbox(),'<input type="checkbox" >')

; is("".Hidden(),'<input type="hidden" >')

; is("".Radio(),'<input type="radio" >')

; is("".Text(),'<input type="text" >')