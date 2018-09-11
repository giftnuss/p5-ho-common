  package HO::HTML::Element
# *************************
; our $VERSION='0.01'
# *******************

; use HO::mixin 'HO::mixin::insertpoint'
; use HO::mixin 'HO::HTML::attribute'
; use HO::mixin 'HO::mixin::attributes'

; use parent ( 'HO::Tag' )

; use HO::class
    _lvalue => _is_single_tag => '$'

; sub _close_stag   () { ' >' } # inline

; sub is_single_tag
    { return $_[0]->_is_single_tag
    }

; 1

__END__


