; use strict; use warnings
; use Test::More # tests => 9

; BEGIN
    { use_ok('HO::Tmpl::Markup::TT','tt')
    }

; ok(tt()->isa('HO::Tmpl::Markup::TT'),'isa Tmpl::TT')

; is(tt->get('var'),'[% var %]')
; is(tt->get('var',123),'[% var(123) %]')

; is(tt->call('call'),'[% CALL call %]')
; is(tt->call('call',123),'[% CALL call(123) %]')

; is(tt->set('greeting','server.greeting'),'[% SET greeting = server.greeting %]')
; is(tt->setq('greeting','hallo'),"[% SET greeting = 'hallo' %]")

; my $copy = '[% SET ten = 10
  twenty = 20
  thirty = twenty + ten
  forty = 2 * twenty
  fifty = 100 div 2
  six = twenty mod 7 %]';

; is(tt->set(ten => 10, twenty => 20, thirty => 'twenty + ten', forty => '2 * twenty',
             fifty => '100 div 2', six => 'twenty mod 7'),$copy)

; done_testing
