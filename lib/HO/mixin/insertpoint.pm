  package HO::mixin::insertpoint
#*******************************
; use HO::accessor ()
; our $VERSION=0.04
#**************************

; use Package::Subroutine

; sub insertpoint
    { my ($self,$insertpoint) = @_
    ; my $idx = $self->__insert
    ; $self->[$idx] = sub
        { my $self = shift()
        ; $insertpoint->insert(@_)
        ; return $self
        }
    ; return $self
    }

; 1

__END__

=head1 NAME

HO::insertpoint - mixin with an alternative insert object method

=head1 SYNOPSIS

=head1 DESCRIPTION





