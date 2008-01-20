  package HO::structure
#**********************
; our $VERSION='0.03'
#********************
; use strict; use warnings

; use Carp qw/carp croak/
;

=head1 NAME

HO::structure - something like an object template

=head1 SYNOPSIS

   package My::Structure::AB;
   use base 'HO::structure';

   __PACKAGE__->auto_slots;

   sub new {
       my $self = shift()->SUPER::new;
       my $a = $self->area_setter;

       my @m = new HO()->copy(3);
       $m[0] << &$a('A',$m[1]) << &$a('B',$m[2]) << "\n";

       return $self->set_root($m[0]);
   }

   # some where else
   my $ab = new My::Structure::AB::;
   $ab->A('HAUS')->B('TIER');

   print $ab; # "HAUSTIER\n"

=head1 DESCRIPTION

=cut

; use HO::class
    _lvalue => _areas => '%',
    _lvalue => _root  => '$'

; sub set_area ($$$)
    { my ($obj,$key,$node) = @_
    ; if( exists $obj->_areas->{$key} )
        { croak "The area '$key' already exists."
        }
    ; unless( $node->can("insert") )
        { croak "The object can not insert something, key: '${key}'"
        }
    ; unless( overload::Method($node,'""') )
        { croak "To string operator is not overloaded, key: '${key}'"
        } 
    ; $obj->_areas->{$key} = $node
    ; return $obj
    }

; sub area_setter ($)
    { my $obj = shift
    ; return sub { $obj->set_area(@_); return $_[1] }
    }

; sub set_root
    { my ($obj,$node)=@_
    ; unless( overload::Method($node,'""') )
        { croak "To string operator is not overloaded for root node."
        } 
    ; $obj->_root = $node
    ; return $obj	
    }

; sub string
    { my ($self) = @_
    ; return "".$self->_root
    }
    
; sub fill ($$@)
    { my ($obj,$key,@args) = @_
    ; $obj->_areas->{$key}->insert(@args)
    ; return $obj
    }

#########################
# Build time operations
#########################
; sub auto_slots
    { my ($self,@args) = @_
    ; my $obj = $self->new(@args)
    ; my @nodes = keys %{$obj->_areas}
    ; $self->make_slots(@nodes)
    }

; sub make_slots
    { my ($self,@nodes)=@_
    ; my $class = ref($self) || $self
    ; my @result
    ; { no strict 'refs'
      ; foreach my $slot (@nodes)
          { if( $class->can($slot) )
              { carp "The class '${class}' has a method '${slot}', no slot defined."
              ; next
              }
          ; *{"${class}::${slot}"} = sub 
              {  shift()->fill("${slot}", @_ ) 
              }
          ; push @result,$slot
          }
      }
    ; return @result
    }

############################
# operator overloading
############################
; use overload
    '""'       => "string",
    'fallback' => 1 

; 1

__END__


; use strict
; use warnings

; package HO::Structure

; use HO
; use Carp

; use base 'HO'
; our $VERSION='0.2.0'

; use constant AREAS => 0
; use constant ROOT  => 2

# Attribute werden noch nicht genutzt, aber es ist besser mit definiert um 
# Kompatibel mit der Basisklasse zu Bleiben 
; sub new
  { my ($class) = @_
  ; bless [ {} , {}  # AREAS , ATTR
          ], $class
  }
  
; sub _areas { $_[0]->[AREAS] }

; sub _root { $_[0]->[ROOT] }

; sub _thread { $_[0]->_root->_thread }

; sub slots
  { my ($class,@nodes)=@_
  ; $class = ref $class if ref $class
  ; eval qq~package $class; sub $_ { shift()->fill( "$_", \@_ ) }~ for @nodes
  }

; sub fill
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

; sub set_area
  {	my ($obj,$key,$node) = @_;
	; unless( $node->can("insert") && $node->can("get") )
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
  {	my ($obj,$node)=@_
  ; croak "Not a valid root object." unless $node->can("get")
  ;	$obj->[ROOT]=$node	
  }

; sub get
  {	my ($obj) = @_;
  ; my $root=$obj->_root
  ; croak "No root for structure." unless $root
  ; return $root->get();
  }

; sub get_area
  {	my ($obj,$key) = @_
  ; my $area=$obj->_areas->{$key}
  ;	croak "$key is not defined." unless $area
  ; $area	
  }

; sub get_root
  {	my ($obj) = @_
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

; 1

__END__

