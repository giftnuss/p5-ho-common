  package HO::Structure
# =====================
; our $VERSION='0.22'
# ===================
; use strict; use utf8
  
; use base 'HO'



; use constant AREAS => 0
; use constant ROOT  => 2

; sub new
  { my ($class) = @_
  ; bless [ {} , {}  # AREAS , ATTR
          ], $class
  }
  
; sub _areas  { $_[0]->[AREAS] }

; sub _root   { $_[0]->[ROOT] }

; sub _thread { $_[0]->_root->_thread }

; sub slots
  { my ($class,@nodes)=@_
  ; $class = ref $class if ref $class
  ; for ( @nodes )
      { eval qq~package $class; sub $_ { shift()->fill( "$_", \@_ ) }~
        unless $class->can($_)
      }
  }
  
; sub area_setter ($)
  { my ($obj)=@_
  ; sub ($$)
    { my ($slot,$area)=@_
    ; $obj->set_area($slot,$area)
    ; $area
    }
  }
  
; sub fill ($$@)
  { my ($obj,$key,@values) = @_
  ; my $area=$obj->_areas->{$key}
  ; if( defined $area )
     { $area->insert( @values ) }
	  else
     { carp "Area $key is not defined!"
     ; return undef
     }
  ; return $area
  }

; sub set_area ($$$)
  { my ($obj,$key,$node) = @_
  ; unless(  $node->can("insert") && $node->can("get") )
     { carp "The area named with $key is not a valid object."
     ; return undef
     }
	; $obj->_areas->{$key} = $node;
  ; $obj
  }

; sub set_alias($$$)
  { my ($obj,$oldkey,$newkey) = @_
  ; my $area = $obj->_areas->{$oldkey}
  ; unless( defined $area )
    { carp "Can not set alias. Unknown area $oldkey!"
    ; return undef
    }
  ; $obj->_areas->{$newkey}=$area
  ; $obj
  }

; sub set_root
  { my ($obj,$node)=@_
  ; croak "Not a valid root object." unless $node->can("get")
  ; $obj->[ROOT]=$node
  }

; sub get
  { my ($obj) = @_;
  ; my $root=$obj->_root
  ; croak "No root for structure." unless $root
  ; return $root->get();
  }

; sub get_area
  { my ($obj,$key) = @_
  ; my $area=$obj->_areas->{$key}
  ; unless( $area )
      { carp "Area $key is not defined."
      ; return undef
      }
  ; $area	
  }

; sub get_root
  { my ($obj) = @_
  ; my $root=$obj->_root
  ; unless( $root )
    { carp "Root object is not defined."
    ; return undef
    }
  ; return $root
  }

; sub set_areas
  { my ($obj,@arg) = @_
  ; my %h;
  ; if( ref $arg[0] eq "HASH" )
     { %h=(%h,%{$_}) foreach @arg }
	  else
     { %h=@arg }
  ; $obj->set_area($_,$h{$_}) foreach keys %h;
  }
  
; sub list_areas
  { my @areas=sort keys %{$_[0]->_areas}
  ; wantarray ? @areas : \@areas
  }

; 1

__END__

# Changelog
# 2005/10/27
# simple register method builder: area_settter
# documantation

# Attribute werden noch nicht genutzt, aber es ist besser mit definiert um 
# Kompatibel mit der Basisklasse zu Bleiben 

=head1 NAME

HO::Structure

=head1 DESCRIPTION

=head2 german

Ein von diesem Modul abgeleitetes Objekt stellt ein Template für Objekte 
zur verfügung. Es können Slots angelegt werden, in die Objekte in 
die Struktur eingefügt werden können.

=head1 SYNOPSIS

    package Hello::World::Structure;
    use base 'HO::Structure';
    
    use HO;
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
    
    use Hello::World::Structure;
    
    my $hw=Hello::World::Structure->new();
    
    # use slot to insert content into 'hello'
    $hw->hello('Hallo');
    
    # use api function for the 'world'
    $hw->fill('world','Welt');
    
    # Show what we have build.
    print $hw->get();
    
=over 2

=item set_area

 Usage     : $self->set_area('SLOT',$object)
 Purpose   : use it in the constructor to make a slot from an object
 Returns   : the object
 Argument  : the name of the slot and the node object
 Throws    : Check if the object implements the basic interface (insert/get)
             and warns if this is not the case.
 See Also  : fill, area_setter

=item TODO

=item this

=item that

=back

=head1 AUTHOR

Sebastian Knapp <sk@computer-leipzig.com>

=head1 SEE ALSO

HO - Hierarchical Objects

=head1 COPYRIGHT

Copyleft (l) 2005 by Sebastian Knapp.  Nearly all rights reserved.

=head1 LICENSE AGREEMENT

This package is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
    
    
    
    
