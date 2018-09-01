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

; sub make_shortcut
    { my ($self, $target, $func) = @_
    ; my $tag   = lc($self->name)
    ; my $class = $self->get_class_name
    ; install Package::Subroutine:: $target, $func
        , sub { $class->new( @_ ) }
    }

; 1

__END__

=head1 NAME

HO::ClassBuilder

=head1 SYNOPSIS

   use HO::ClassBuilder;

   my $builder = HO::ClassBuilder->new
        ( name => 'Img'
        , namespace => ['HO','HTML','Element']
        , version => $VERSION
        , parents => [ 'HO::HTML::Element' ]
        , methods =>
            { init => sub { ... }
            }
        );
   $builder->build;
   $builder->make_shortcut(__PACKAGE__, $elements[$p]->[1]);

=head1 DESCRIPTION

