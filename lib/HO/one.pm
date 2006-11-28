
; use strict; use warnings

; package HO::one
; use base 'HO'

; sub insert
    { my $self=shift
    ; pop @{$self->_thread}
    ; $self->SUPER::insert(@_)
    }

; 1

__END__

=head1 NAME

   HO::one
   
=head1 DESCRIPTION

A Object where before a item is inserted the last item is removed.
If is always a single parameter inserted, the thread holds ever 
only one object.

=cut

=head1 SEE ALSO

C<HO>

=cut

