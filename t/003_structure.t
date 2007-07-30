# -*- perl -*-

# t/001_load.t - check module loading and basic functionality

use Test::More tests => 4;

BEGIN { use_ok( 'HO::structure' ); }

my $object = HO->new ();
isa_ok ($object, 'HO');

my $structure = new HO::structure;
isa_ok ($structure, 'HO');
isa_ok ($structure, 'HO::structure');

__END__
$object->insert("abc");
is("$object","abc","simple insert and stringify");

$object->replace("cba");
is("$object","cba","simple replace");

my $doubled = new HO($object->copy(2));
is("$doubled","cbacba","simple multiply");

ok($doubled->count==2,"count is 2");
