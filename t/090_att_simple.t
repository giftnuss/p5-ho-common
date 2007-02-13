
# teste HO::attr
; use strict
; use Test::More tests => 2

; BEGIN { use_ok('HO::attr') }

; my $t=new HO::attr(1..3)

; $t-> hallo = "welt"

; is("$t",'<1 hallo="welt">23</1>')
;

