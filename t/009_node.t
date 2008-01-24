; use strict; use warnings
; use Test::More tests => 4

; BEGIN { use_ok('HO::node') }

; my $node = new HO::node
; isa_ok($node,'HO::node')

; is("$node","")

; ok($node->can("insertpoint"))