  package HO::attr
# ****************
; use base 'HO'
; our $VERSION=$HO::VERSION
# *************************
; use Carp
; use constant ATTRIBUTES => 1

; sub new 
    { my ($self,@args)=@_
    ; $self=$self->SUPER::new(@args)
    ; $self->_attributes = {}
    ; $self
    }

; sub _attributes { $_[0]->[ATTRIBUTES] }

; sub AUTOLOAD : lvalue
    { my $self=shift
    ; our $AUTOLOAD
    ; croak "AUTOLOAD ($AUTOLOAD) called without object." unless ref $self
    ; carp "AUTOLOAD: ".$AUTOLOAD if $HO::DEBUG_AUTOLOAD
    ; $AUTOLOAD =~ s/.*:://
    ; my @arg=@_
    ; if( @arg )
        { $self->set_attribute($AUTOLOAD, @arg)
        ; return $self
        }
      else
        { return $self->get_attribute($AUTOLOAD) }
    }

; sub set_attribute
    { my ($self,$key,$value)=@_
    ; $self->_attributes->{$key} = $value
    ; $self
    }

; sub get_attribute : lvalue
    { my ($self,$key)=@_
    ; $self->_attributes->{$key}
    }

; sub bool_attribute
    { $_[0]->set_attribute($_[1],undef) }

; sub set_attributes
    { my ($obj,%attr)=@_
    ; $obj->set_attribute($_,$attr{$_}) for keys %attr
    ; $obj
    }

; 1

__END__
