  package HO::XML
# ***************
; our $VERSION='0.03'
# *******************
; use strict; use warnings

; use HO::mixin 'HO::mixin::insertpoint'
; use HO::mixin 'HO::mixin::attributes'

; use parent qw(HO::Tag)

# Am besten wäre es eine Möglichkeit zu haben den default code einer Methode
# ebenfalls noch ändern zu können.
; use HO::class
    _method => 'namespace' => sub {undef}

; sub _single_tag
    { my ($self) = @_

    ; my $r = $self->_begin_tag
    ; $r   .= $self->namespace . ':' if $self->namespace
    ; $r   .= $self->_tag . $self->attributes_string . $self->_close_stag
    ; return $r
    }

; sub _double_tag
    { my ($self) = @_

    ; my $begin = $self->_begin_tag
    ; my $end   = $self->_begin_endtag
    ; if($self->namespace)
        { $begin .= $self->namespace . ':'
        ; $end   .= $self->namespace . ':'
        }
    ; $begin .= $self->_tag . $self->attributes_string() . $self->_close_tag
    ; $end   .= $_[0]->_tag . $_[0]->_close_tag
    ; foreach my $cld ($_[0]->content)
        { $begin .= "$cld"
        }
    ; return $begin.$end
    }

# ***********************
#     Class Methods
# ***********************
; sub get_class_builder
    { my ($self, $tag, %args) = @_
    ; unless(exists $args{'parents'})
        { $args{'parents'} = ['HO::XML']
        }
    ; unless(exists $args{'methods'}{'init'})
        { $args{'methods'}{'init'} = sub
            { my ($self, @args) = @_
            ; $self->insert($tag, @args)
            }
        }
    ; return new HO::ClassBuilder:: (%args)
    }

; 1

__END__
