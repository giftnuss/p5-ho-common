# -*- perl -*-

# t/020_tag.t - check module loading and the simple api

; use Test::More tests => 7

; BEGIN
    { use_ok('HO::tag') }
    
; my $a=new HO::tag('p')
; ok(is_single_tag $a ())
; is("$a",'<p />','without content it is a single tag')

; is($a->_tag,'p','test tag method')
  
; $a->_tag = 'b'
; is($a->_tag,'b','change tag with this lvalue method')

; my $b=new HO::tag
; $b->_tag="a"
; $b->insert("bc")
; is("$b","<a>bc</a>","with some little content")

; $b->replace("cb")
; is("$b","<a>cb</a>","content was replaced")
;
