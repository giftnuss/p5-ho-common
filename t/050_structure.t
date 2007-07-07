# -*- perl -*-

use Test::More tests => 3;

BEGIN { use_ok( 'HO::Structure' ); }

ok( defined $HO::Structure::VERSION , "Version" );

my $object = new HO::Structure();
isa_ok ($object, 'HO');
