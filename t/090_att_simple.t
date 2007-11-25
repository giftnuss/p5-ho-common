
# teste HO::attr
; use strict
; use Test::More tests => 4

; BEGIN { use_ok('HO::attr') 
        ; use_ok('HO::tag')
        }

; my $a=new HO::attr(1..3)
; my $t=new HO::tag(1..3)

; $a-> hallo = "welt"
; $t-> hallo = "welt"

; is("$a",'123')
; is("$t",'<1 hallo="welt">23</1>')

