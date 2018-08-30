# -*- perl -*-

###############################################################################
# t/003_structure.t - check module loading and basic functionality
###############################################################################
use strict;
use warnings;
use Test::More tests => 22;

################
# load 2
################
BEGIN { use_ok( 'HO::Structure' )
      ; use_ok( 'HO::Object' )
      };

################
# create 1
################
my $structure = new HO::Structure::;
isa_ok ($structure, 'HO::Structure');

################
# Version 2
################
ok( defined $HO::Structure::VERSION , "Version" );

################
# isa 1
################
ok(!@HO::structure::ISA,'empty ISA');

################
# internals 2
################
diag("is_deeply calls stringify with a empty object, please ignore these warnings here");
is_deeply(new HO::Structure::(),bless [{},undef],'HO::Structure');
is_deeply(new HO::Structure::()->_areas,{});

################
# return values 2
################
my @m = (new HO::Object::('A'),new HO::Object::('B'));
my $root = new HO::Object::(@m);

isa_ok ($structure->set_root($root), 'HO::Structure', 'set_root returns self');
isa_ok ($structure->set_area('A',$m[0]),'HO::Structure', "set_area returns self");
$structure->set_area('B',$m[1]);

################
# stringify 1
################
is("$structure","AB",'stringify works');

isa_ok($structure->fill('B','C'),'HO::Structure', "fill returns self");

is("$structure","ABC",'stringify works');

####################
# Internals
####################
is($structure->__areas,0,"__areas == 0");
is($structure->__root,1 ,"__root  == 1");

isa_ok($structure->_areas,"HASH");
isa_ok($structure->_root,'HO::Object');

####################
# Building a simple
# subclass
####################
eval
    { package TestMe::Structure;
      no warnings 'void';
      our @ISA = ('HO::Structure');

      sub new {
          my $self = shift->SUPER::new;
          my $a = $self->area_setter;

          my @m = new HO::Object()->copy(3);
          $m[0] << &$a('A',$m[1]) << &$a('B',$m[2]) << "\n";

          return $self->set_root($m[0]);
      }

      __PACKAGE__->auto_slots;
    };

diag($@) if $@;
ok(!$@);

my $ab = TestMe::Structure->new;

is($ab->__areas,0,"__areas == 0");
is($ab->__root,1 ,"__root  == 1");


isa_ok($ab->_areas,"HASH");
isa_ok($ab->_root,'HO::Object');

$ab->A('HAUS')->B('TIER');

is("$ab", "HAUSTIER\n");


__END__

