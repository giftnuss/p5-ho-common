# -*- perl -*-

###############################################################################
# t/001_load.t - check module loading and basic functionality
###############################################################################
use strict;
use warnings;

use Test::More tests => 14;

BEGIN { use_ok( 'HO' ); }

my $object = HO->new ();
isa_ok ($object, 'HO');

$object->insert("abc");
is("$object","abc","simple insert and stringify");

$object->replace("cba");
is("$object","cba","simple replace");

my $second = new HO('jup');
is("$second",'jup','constr with argument');

my $doubled = new HO($object->copy(2));
is("$doubled","cbacba","simple multiply");

ok($doubled->count==2,"count is 2");

is(''.$doubled->splice(0,1,'gfe','jki'),'cba','splice result');

is("$doubled",'gfejkicba','object after splice');

ok( overload::Method($object,'""'),"stringify operator is overloaded");

# restrict further development
is_deeply(new HO::(),(bless [[],undef],'HO'));
ok(new HO::()->__thread==0);
ok(new HO::()->_insert==1);
is_deeply(new HO::()->_thread,[]);




