  package HO::attr
# ****************
; use base 'HO'
; our $VERSION=$HO::VERSION
# *************************
; use strict

; use Carp ()
  
; our ($AUTOLOAD)
  
; DEFDEBUG:
  { no strict 'refs'
  ; unless( defined *HO::attr::DEBUG_AUTOLOAD{'CODE'} )
      { sub DEBUG_AUTOLOAD () { 0 }
      }
  }

; use HO::class
    accessor => __attributes => '%'

; sub _attributes { $_[0]->[&__attributes] }

; sub AUTOLOAD : lvalue
    { my $self=shift
    ; Carp::croak "AUTOLOAD ($AUTOLOAD) called without object." 
	  unless ref $self
    ; Carp::carp "AUTOLOAD: ".$AUTOLOAD if DEBUG_AUTOLOAD
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

; sub has_attribute
    { my ($self,$key)=@_
    ; exists $self->_attributes->{$key}
    }

; sub bool_attribute
    { $_[0]->set_attribute($_[1],undef) }

; sub set_attributes
    { my ($obj,%attr)=@_
    ; $obj->set_attribute($_,$attr{$_}) for keys %attr
    ; $obj
    }

; sub attributes_string
    { my ($self) = @_
    ; my ($r,$v) = ("","")
    ; my %attr   = %{$self->_attributes}
    ; foreach ( keys %attr )
        { $v=$attr{$_}
	; $r .= ref $v       ? sprintf(" %s=\"%s\"",$_,"$v") 
	      : ! defined $v ? sprintf(" %s",$_)
	      : sprintf(" %s=\"%s\"",$_,$v)
        }
    ; return $r
    }

; 1

__END__
