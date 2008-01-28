; use strict; use warnings
; use Test::More tests => 2

; BEGIN
    { use_ok('HO::HTML')
    }
    
; is_deeply([HO::HTML::->list_loaded],[HO::HTML::->list_names])