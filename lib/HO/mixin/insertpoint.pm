  package HO::mixin::insertpoint
#*******************************
; use HO::accessor ()
; our $VERSION=0.030
#**************************

; sub insertpoint
    { my ($self,$insertpoint) = @_
    ; my $class = ref($self) || $self
    ; my $idx = HO::accessor::_value_of($class,"_insert")
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



