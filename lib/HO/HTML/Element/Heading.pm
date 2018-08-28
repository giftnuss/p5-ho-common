  package HO::HTML::Element::Heading
# **********************************
; our $VERSION='0.01'
# *******************

; use parent ('HO::HTML::Element')

; use HO::class
    _rw => level => '$'

; sub default_level
    { my ($self) = @_
    ; return undef unless $self->_tag
    ; return ($self->_tag =~ /.*(\d+)(_.*)?$/ && $1) || 1
    }

; 1

__END__

