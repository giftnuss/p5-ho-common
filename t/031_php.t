; use strict
; use warnings
; use Test::More tests => 3

; BEGIN
    { use_ok('HO::PHP', 'php')
    }
    
; is("".php(),'<?php  ?>')
; is("".php('echo "Test"'),'<?php echo "Test" ?>')