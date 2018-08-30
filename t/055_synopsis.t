# -*- perl -*-

# test the synopsis
use strict;
use warnings;

use Test::More tests => 3;

my $other_object = bless \my $str,'class::ok';
$str = 'lol';
my $another_object = bless \my $stg,'class::ok';

{ package class::ok;
  use overload '""' => sub { my $self=shift; $$self },
               '**' => sub { my $self=shift; $$self = '_'. shift; }
};

###########################################################################
# Synopsis 2007 v0.61
   use HO::Object;
   no warnings 'void';

   my $obj=new HO::Object:: ('text',$other_object);

   $obj->insert('more text');
   $obj << $another_object ** 'anymore text';

   is "$obj","textlolmore text_anymore text";

###########################################################################

    package Hello::World::Structure;
    use base 'HO::Structure';

    Test::More::ok(!@HO::Structure::ISA,'empty ISA');

    # basic structure using HO

    __PACKAGE__->auto_slots;

    { no strict 'refs'
    ; no warnings 'once'
    ; *get = \&HO::Structure::string
    };

    sub new
        { my ($package,@p)=@_
        ; my $self=$package->SUPER::new()

        ; my ($HW,$hello,$world)=new HO::Object::()->copy(3)

        ; my $area=$self->area_setter()

        # use the area closure to define area 'hello'
        ; $HW << &$area('hello',$hello) << " " << $world << "!\n"

        # use the api function to set area 'world'
        ; $self->set_area('world',$world)

        ; $self->set_root($HW)
        ; $self
        }

    # somewhere else
    package main;

    # use Hello::World::Structure;
    my $hw=Hello::World::Structure->new();

    # use slot to insert content into 'hello'
    $hw->hello('Hallo');

    # use api function for the 'world'
    $hw->fill('world','Welt');

    # Show what we have build.
    is( $hw->get(), "Hallo Welt!\n");


