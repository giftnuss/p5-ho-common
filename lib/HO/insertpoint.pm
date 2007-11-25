  package HO::insertpoint
#************************
; require HO
; require HO::accessor
; our $VERSION=$HO::VERSION
#**************************

; sub insertpoint
    { my ($self,$insertpoint) = @_
    ; my $idx = _value_of HO::accessor "_insert"
    ; $self->[$idx] = sub
        { shift(); $insertpoint->insert(@_)
        }
    ; return $self
    }

; 1

__END__



