  package HO::PHP
# ***************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
; use base ('HO','Exporter')

; our @EXPORT
; our @EXPORT_OK = ('php')

; sub php
    { return new HO::PHP::(@_)
    }

; sub string
    { my $self = shift
    ; return '<?php ' . join("",$self->content) . ' ?>'    
    }
    
; 1

__END__

