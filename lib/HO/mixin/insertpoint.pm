  package HO::mixin::insertpoint
# ******************************
; our $VERSION=0.05
# *****************

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

This mixin uses the ability to change an method on a per object base.

This mixin contains one new method.

=over 4

=item insertpoint

This method gets one object which will be used for all following calls
of C<insert> as point, where the arguments will be inserted.





