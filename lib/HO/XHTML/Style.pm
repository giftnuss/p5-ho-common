  package HO::XHTML::Style
# ************************
; our $VERSION = '0.01'
# *********************
; use strict; use warnings; use utf8

; use parent 'HO::HTML::Style'

; use HO::common qw/newline/

; sub Style
    { HO::HTML::Style('/* <![CDATA[ */',newline(@_),'/* ]]> */')->type('text/css')
    }


; 1

__END__

