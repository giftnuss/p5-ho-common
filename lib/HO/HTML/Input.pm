  package HO::HTML::Input
# ***********************
; our $VERSION='0.02'
# *******************
; use strict; use warnings

; require Exporter  
; our @ISA = ('Exporter')
; our @EXPORT
; our @EXPORT_OK = qw/IButton Checkbox Hidden Radio Text/

; use HO::HTML functional => [qw/Input/]

; sub IButton  { return Input(@_)->type('button') }

; sub Checkbox { return Input(@_)->type('checkbox') }

; sub Hidden   { return Input(@_)->type('hidden') }

; sub Radio    { return Input(@_)->type('radio') }

; sub Text     { return Input(@_)->type('text') }

; 1

__END__