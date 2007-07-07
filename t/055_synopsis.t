# -*- perl -*-

# test the synopsis
use strict;
use warnings;
no warnings 'void';

use Test::More tests => 1;

    package Hello::World::Structure;
    use base 'HO::Structure';
    
    use HO;
    # $HO::DEBUG_AUTOLOAD=1;
    # basic structure using HO 
    
    sub import
        { shift()->slots(qw/hello world/) }
    
    sub new
        { my ($package,@p)=@_
        ; my $self=$package->SUPER::new()
        
        ; my ($HW,$hello,$world)=new HO()->copy(3)
        
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
    Hello::World::Structure->import;
    my $hw=Hello::World::Structure->new();
    
    # use slot to insert content into 'hello'
    $hw->hello('Hallo');
    
    # use api function for the 'world'
    $hw->fill('world','Welt');
    
    # Show what we have build.
    is( $hw->get(), "Hallo Welt!\n");
    

