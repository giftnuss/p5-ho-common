# -*- perl -*-

# t/001_load.t - check module loading and basic functionality

use Test::More tests => 7;

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
