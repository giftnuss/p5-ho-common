# -*- perl -*-

use Test::More tests => 4;

BEGIN { use_ok( 'HO::structure' ); }

ok( defined $HO::structure::VERSION , "Version" );

my $object = new HO::structure();
isa_ok ($object, 'HO');
isa_ok ($object, 'HO');
