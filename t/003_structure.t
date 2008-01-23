# -*- perl -*-

###############################################################################
# t/003_structure.t - check module loading and basic functionality
###############################################################################
use strict;
use warnings;
use Test::More tests => 11;

################
# load 2
################
BEGIN { use_ok( 'HO::structure' ); 
        use_ok( 'HO' );
      };

################
# create 1
################
my $structure = new HO::structure;
isa_ok ($structure, 'HO::structure');

################
# Version 2
################
ok( defined $HO::structure::VERSION , "Version" );
ok( $HO::structure::VERSION = $HO::VERSION ,"same Version as HO" );

################
# isa 1
################
ok(!@HO::structure::ISA,'empty ISA');

################
# internals 2
################
diag("is_deeply calls stringify with a empty object, please ignore these warnings here");
is_deeply(new HO::structure::(),bless [{},undef],'HO::structure');
is_deeply(new HO::structure::()->_areas,{});

################
# return values 2
################
my @m = (new HO('A'),new HO('B'));
my $root = new HO(@m);

isa_ok ($structure->set_root($root), 'HO::structure', 'set_root returns self');
isa_ok ($structure->set_area('A',$m[0]),'HO::structure', "set_area returns self");
$structure->set_area('B',$m[1]);

################
# stringify 1
################
is("$structure","AB",'stringify works');


__END__

