  package HO::insertpoint
#************************
; require HO
; require HO::accessor
; our $VERSION=$HO::VERSION
#**************************

; sub insertpoint
    { my ($self,$insertpoint) = @_
    ; my $class = ref($self) || $self
    ; my $idx = HO::accessor::_value_of($class,"_insert")
    ; $self->[$idx] = sub
        { shift(); $insertpoint->insert(@_)
        }
    ; return $self
    }

; 1

__END__



