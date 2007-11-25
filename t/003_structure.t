# -*- perl -*-

# t/001_load.t - check module loading and basic functionality

use Test::More tests => 7;

BEGIN { use_ok( 'HO::structure' ); 
        use_ok( 'HO' );
      };

my $object = HO->new ();
isa_ok ($object, 'HO');

my $structure = new HO::structure;
isa_ok ($structure, 'HO::structure');

my @m = (new HO('A'),new HO('B'));
my $root = new HO(@m);

isa_ok ($structure->set_root($root), 'HO::structure', 'set_root returns self');
isa_ok ($structure->set_area('A',$m[0]),'HO::structure', "set_area returns self");
$structure->set_area('B',$m[1]);

is("$structure","AB",'stringify works');


__END__
$object->insert("abc");
is("$object","abc","simple insert and stringify");

$object->replace("cba");
is("$object","cba","simple replace");

my $doubled = new HO($object->copy(2));
is("$doubled","cbacba","simple multiply");

ok($doubled->count==2,"count is 2");
