# -*- perl -*-

###############################################################################
# t/003_structure.t - check module loading and basic functionality
###############################################################################
use strict;
use warnings;
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

