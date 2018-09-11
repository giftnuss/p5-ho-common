  package HO::Node
# ****************
; our $VERSION=0.068
# ******************

; use Class::Data::Localize ()
; use subs qw/init/

; our ($AUTOLOAD)

; use HO::Object

;  my $load

; unless($load)
    { $load = 1
    ; my ($mkcd,$self) = (\&Class::Data::Localize::mk_classdata,__PACKAGE__)
    ; $mkcd->($self, 'node_factory' => sub { new HO::Object:: (@_) });
    }

; use HO::class
    _ro => _object => '$'

; sub init
    { my ($self, @args) = @_
    ; $self->[&__object] = $self->node_factory->(@args)
    ; $self
    }

; sub insert
    { my ($self,@args) = @_
    ; $self->_object->insert( @_ )
    ; $self
    }

; sub DESTROY
    { shift->[&__object] = undef
    }

; sub AUTOLOAD
    { my $self=shift
    ; $AUTOLOAD =~ s/.*:://
    ; $self->_object->$AUTOLOAD(@_)
    }

; use overload
    '<<'     => sub { shift()->_object->insert( @_ ) },
    '**'     => sub { shift()->_object->insert( @_ ) },
    '""'     => sub { shift()->_object->string( @_ ) },
    '+'      => sub { shift()->_object->concat( @_ ) },
    '*'      => sub { shift()->_object->copy( @_ ) },
    'bool'   => sub{ 1 },
    fallback => 1,
    nomethod => sub
        { require Carp
        ; Carp::croak "illegal operator $_[3]."
        }

; 1

__END__

TODO: Das sollte eine Fassade werden um verschiedenen Objekten ein
gemeinsames Interface zu geben.

