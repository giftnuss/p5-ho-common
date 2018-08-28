; use strict; use warnings
; use Test::More tests => 4

; BEGIN { use_ok('HO::Node') }

; my $node = new HO::Node::
; isa_ok($node,'HO::Node')

; is("$node","")

; ok($node->can("insertpoint"))
