  package HO::structure
#**********************
; our $VERSION='0.03'
#********************
; use strict; use warnings

; use Carp qw/carp croak/

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
    
; sub has_area ($$)
    { my ($obj,$key) = @_
    ; return defined($obj->_areas->{$key})
    }
    
; sub get_area ($$)
    { my ($obj,$key) = @_
    ; return $obj->_areas->{$key}
    }
    
; sub list_areas ($)
    { my ($obj) = @_
    ; return keys %{$obj->_areas}
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
    
; sub get_root
    { my ($obj) = @_
    ; return $obj->_root
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
              { my ($self,@args) = @_
              ; if(@args)
                  { return $self->fill("${slot}", @args ) }
                else
                  { return $self->get_area("${slot}") }
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

=head2 NOTES

Bei Vererbung kann der Constraint in Zeile 48 nervig werden.

#ERwähnung sollte finden das diese Klasse keine init Methode hat.
