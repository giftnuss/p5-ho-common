# -*- perl -*-

###############################################################################
# t/001_load.t - check module loading and basic functionality
###############################################################################
use strict;
use warnings;

use Test::More tests => 14;

BEGIN { use_ok( 'HO::Object' ); }

my $object = HO::Object->new ();
isa_ok ($object, 'HO::Object');

$object->insert("abc");
is("$object","abc","simple insert and stringify");

$object->replace("cba");
is("$object","cba","simple replace");

my $second = new HO::Object::('jup');
is("$second",'jup','constr with argument');

my $doubled = new HO::Object::($object->copy(2));
is("$doubled","cbacba","simple multiply");

ok($doubled->count==2,"count is 2");

is(''.$doubled->splice(0,1,'gfe','jki'),'cba','splice result');

is("$doubled",'gfejkicba','object after splice');

ok( overload::Method($object,'""'),"stringify operator is overloaded");

# restrict further development
ok(new HO::Object::()->__thread==0,"internals 1");
ok(new HO::Object::()->__insert==1,"internals 2");
ok(new HO::Object::()->_insert==2,"internals 3");
is_deeply(new HO::Object::()->_thread,[],"internals 4");




