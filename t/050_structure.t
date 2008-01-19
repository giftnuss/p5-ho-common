# -*- perl -*-

use Test::More tests => 3;

BEGIN { use_ok( 'HO::structure' ); }

ok( defined $HO::structure::VERSION , "Version" );

my $object = new HO::structure();
isa_ok ($object, 'HO::structure');

