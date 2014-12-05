  package HO::accessor::stack
# +++++++++++++++++++++++++++
; our $VERSION='0.01'
# +++++++++++++++++++
; no warnings 'void'

# inject it only one time
; my $loaded

; sub import
    { my $package = shift
    # register type
    ; $HO::accessor::type{'stack'} = sub { $package->new }
    
    # define the accessor
    ; $HO::accessor::rw_accessor{'stack'} = sub
        { my ($n,$i) = @_
        ; return sub { my ($obj,$idx,$val) = @_
                     ; if(@_==1)
                         { return $obj->[$i]
                         }
                     }
        }
    }
	
# this is by itself a HO descendent
; use HO::class _rw => _self => '@'

; sub top
    { return $_[0]->[__self]->[@{$_[0]->[__self]}-1]
    }
    
; sub push
    { my $self = shift
    ; return CORE::push(@{$self->[__self]},@_)
    }
    
; sub pop
    { return CORE::pop(@{$_[0]->[__self]})
    }
    
; sub is_empty
    { return @{$_[0]->[__self]} == 0
    }

    
; 1

__END__

