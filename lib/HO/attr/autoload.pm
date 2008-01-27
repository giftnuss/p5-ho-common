  package HO::attr::autoload
# ++++++++++++++++++++++++++
; use base 'HO::attr'
; our $VERSION=$HO::VERSION
# +++++++++++++++++++++++++

; our ($AUTOLOAD)

; DEFDEBUG:
  { no strict 'refs'
  ; unless( defined *HO::attr::autoload::DEBUG{'CODE'} )
      { sub DEBUG () { 0 }
      }
  }
  
; sub AUTOLOAD : lvalue
    { my $self=shift
    ; Carp::croak "AUTOLOAD ($AUTOLOAD) called without object." 
	  unless ref $self
    ; Carp::carp "AUTOLOAD: ".$AUTOLOAD if DEBUG
    ; $AUTOLOAD =~ s/.*:://
    ; my @arg=@_
    ; if( @arg )
        { $self->set_attribute($AUTOLOAD, @arg)
        ; return $self
        }
    # don't say return, it is a lvalue sub
    ; $self->get_attribute($AUTOLOAD)
    }
    
; 1

__END__

