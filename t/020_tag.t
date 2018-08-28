# -*- perl -*-

# t/020_tag.t - check module loading and the simple api

; use Test::More tests => 9

; BEGIN { use_ok('HO::Tag') }

; is_deeply(new HO::Tag::()->_attributes,{},"internals 1")
; is_deeply(new HO::Tag::()->_thread,[],"internals 2")

; my $a=new HO::Tag::('p')
; ok(is_single_tag $a ())
; is("$a",'<p />','without content it is a single tag')

; is($a->_tag,'p','test tag method')

; $a->_tag = 'b'
; is($a->_tag,'b','change tag with this lvalue method')

; my $b=new HO::Tag
; $b->_tag="a"
; $b->insert("bc")
; is("$b","<a>bc</a>","with some little content")

; $b->replace("cb")
; is("$b","<a>cb</a>","content was replaced")
;
; ; END
    { if(0)
        { require Module::Versions::Report
        ; print Module::Versions::Report::report()
        }
    }
