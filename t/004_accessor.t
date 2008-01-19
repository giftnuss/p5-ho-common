use strict;

use Test::More tests => 10;

require_ok('HO::accessor');

package T::one;
use HO::accessor [__t => '$'];

my $t1 = new T::one;
Test::More::isa_ok($t1,'T::one');

Test::More::is(ref $t1->[0], '');

sub tm1 : lvalue { shift->[__t] }

package main;

ok($t1->tm1 = 'trf');
is($t1->tm1,'trf');

package T::one_without_constr;
use base 'T::one';

my $twc = new T::one_without_constr;

Test::More::isa_ok($twc,'T::one_without_constr');

my $tw2 = $twc->new;

Test::More::isa_ok($tw2,'T::one_without_constr');

; package T::entity
; BEGIN 
    { Test::More::use_ok
        ( 'HO::class',
             _ro => name => '$',
             _ro => href => '$'
        )
    }
    
; my $e = new T::entity::
; $e->[$e->_name] = 'timestamp'
; $e->[$e->_href] = 'http://localhost:8091/time/'

; Test::More::is($e->name,'timestamp')
; Test::More::is($e->href,'http://localhost:8091/time/')
    


