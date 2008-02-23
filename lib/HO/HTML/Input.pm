  package HO::HTML::Input
# ***********************
; our $VERSION='0.02'
# *******************
; use strict; use warnings

; use HO::HTML functional => [qw/Input/]

; our @ISA = ('HO::HTML')
; our @EXPORT
; our @EXPORT_OK = qw/IButton Checkbox Hidden Radio Text/
; our %EXPORT_TAGS = (all => \@EXPORT_OK)

; sub IButton  { return Input(@_)->type('button') }

; sub Checkbox { return Input(@_)->type('checkbox') }

; sub Hidden   { return Input(@_)->type('hidden') }

; sub Radio    { return Input(@_)->type('radio') }

; sub Text     { return Input(@_)->type('text') }

; 1

__END__

=head1 NAME

HO::HTML::Input

=head1 SYNOPSIS
