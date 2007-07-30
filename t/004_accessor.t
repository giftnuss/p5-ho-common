use strict;

use Test::More tests => 7;

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


