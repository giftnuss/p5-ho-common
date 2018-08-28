  package HO::mixin::attributes::autoload
# +++++++++++++++++++++++++++++++++++++++
; our $VERSION=0.064
# ++++++++++++++++++
; use strict; use warnings

; use parent 'HO::mixin::attributes'
; use Carp ()
; our ($AUTOLOAD)

; use HO::class

; DEFDEBUG:
  { no strict 'refs'
  ; unless( defined *HO::mixin::attributes::autoload::DEBUG_AUTOLOAD{'CODE'} )
      { sub DEBUG_AUTOLOAD () { 0 }
      }
  }

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
    # don't say return, it is a lvalue sub
    ; $self->get_attribute($AUTOLOAD)
    }

; 1

__END__
