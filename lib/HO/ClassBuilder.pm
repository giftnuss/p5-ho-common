  package HO::ClassBuilder;
# *************************
  our $VERSION = '0.001';
# ***********************
; use strict; use warnings
; use 5.010

; use Carp ()
; use Package::Subroutine ()

; use Data::Dumper

; use HO::class
    ( _ro       => namespace => '@'
    , _ro       => name      => '$'
    , _rw       => version   => sub { 0.01 }
    , _rw       => parents   => '@'
    , _rw       => methods   => '%'
    , init => 'hash'
    )

; sub get_class_name
    { my ($self) =@_
    ; if(!defined($self->name) || length($self->name) == 0)
        { Carp::croak("ClassBuilder needs at least a name to build a class.")
        }
    ; return join('::', $self->namespace, $self->name)
    }

; sub build
    { my ($self) = @_
    ; my $class = $self->get_class_name
    ; { no strict 'refs'
      ; ${"$class\::VERSION"} = $self->version
      ; push @{"$class\::ISA"}, $self->parents

      ; my %methods = %{$self->methods}
      ; while(my($method, $subref) = each %methods)
        { install Package::Subroutine:: $class, $method, $subref
        }

      ; { local $HO::accessor::class = $class
        ; HO::class->import
        }
      ; 1
      }
    }

; 1

__END__


; sub make_subclass
  { my %args = @_
  ; $args{'of'}   ||= [ "".caller(1) ]
  ; $args{'name'} || Carp::croak('no name')
  ; unless( defined $args{'in'} )
      { $args{'in'} = $args{'of'}->[0]
      }
  ; unless($args{'code'})
      { if(ref $args{'codegen'})
          {
            $args{'code'} = $args{'codegen'}->(%args)
          }
        else
          { $args{'code'} = "$args{'codegen'}"
          }
      }
  # optional shortcut_in
  ; my $code = 'package '.$args{'in'}.'::'.$args{'name'}.';'
             . 'our @ISA = qw/'.join(' ',@{$args{'of'}}).'/;' . $args{'code'}
  ; if($args{'shortcut_in'})
      { my $sc = $args{'shortcut'} || $args{'name'}
      ; $code .= 'package '.$args{'shortcut_in'}.';'
           . 'sub '.$sc.' { new '.$args{'in'}.'::'.$args{'name'}.'::(@_) }'
      }
  ; eval $code
  ; Carp::croak($@) if $@
  }
