  package HO::HTML::element
# *************************
; our $VERSION='0.01'
# *******************

; use base ( 'HO::tag'
           , 'HO::insertpoint'
           , 'HO::HTML::attribute'
           , 'HO::attr::autoload'
           )

; use HO::class
    _lvalue => _is_single_tag => '$'

; use subs qw/init/

; sub _close_stag   () { ' >' } # inline

; sub is_single_tag 
    { return $_[0]->_is_single_tag
    }


; package HO::HTML::element::header
# *********************************
; our $VERSION='0.01'
# *******************

; use base ('HO::HTML::element')

; use HO::class
    _rw => level => '$' 
    
; sub default_level
    { my ($self) = @_
    ; return undef unless $self->_tag
    ; return ($self->_tag =~ /.*(\d+)(_.*)?$/ && $1) || 1
    }

; 1

__END__


