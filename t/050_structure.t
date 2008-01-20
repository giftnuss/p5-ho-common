# -*- perl -*-

use Test::More tests => 6;

BEGIN { use_ok( 'HO::structure' ); }

ok( defined $HO::structure::VERSION , "Version" );

my $object = new HO::structure();
isa_ok ($object, 'HO::structure');

ok(!@HO::structure::ISA,'empty ISA');

is_deeply(new HO::structure::(),bless [{},undef],'HO::structure');
is_deeply(new HO::structure::()->_areas,{});

my $acc = HO::accessor->accessors_for_class('HO::structure');
print join("\n",@$acc);



