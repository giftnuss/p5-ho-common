; use strict; use warnings
; use Test::More tests => 4

; BEGIN
    { use_ok('HO::HTML')
    }
    
; is_deeply([HO::HTML::->list_loaded],[HO::HTML::->list_names])

; is("".HO::HTML::A(),'<a></a>')

; ok(HO::HTML::Script()->can("insertpoint"))