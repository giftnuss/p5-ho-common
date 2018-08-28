  package HO::HTML::Element
# *************************
; our $VERSION='0.01'
# *******************

; use parent ( 'HO::Tag'
             , 'HO::mixin::insertpoint'
             , 'HO::HTML::attribute'
             , 'HO::mixin::attributes::autoload'
             )

; use HO::class
    _lvalue => _is_single_tag => '$'

; sub _close_stag   () { ' >' } # inline

; sub is_single_tag
    { return $_[0]->_is_single_tag
    }

; 1

__END__


