
# teste HO::attr
; use strict
; use Test::More tests => 2

; BEGIN { use_ok('HO::attr::autoload') 
        }

; my $a=new HO::attr::autoload(1..3)

; $a-> hallo = "welt"

; is("$a",'123')


