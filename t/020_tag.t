# -*- perl -*-

# t/020_tag.t - check module loading and the simple api

; use Test::More tests => 7

; BEGIN
    { use_ok('HO::tag') }
    
; my $a=new HO::tag('a')
; is($a,'a','HO::Tag\'s output is like HO')

; is($a->tag,'a','test tag method')

; $a->tag = 'b'
; is($a->tag,'b','change tag with this lvalue method')

; my $test
; close STDERR
; open(STDERR,">",\$test) or die "$!"
; my $b=new HO::tag()
; close STDERR

; like($test,qr/missing argument tagname/,"check warning because missing argument")

; $b->tag="a"
; $b->insert("bc")
; is($b,"abc","with some little content")

; $b->replace("cb")
; is($b,"acb","content was replaced")
;
