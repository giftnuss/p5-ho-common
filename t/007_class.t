
; use strict
; use Test::More tests => 4

; use_ok('HO::class')

; package H::first
; use HO::class _method => hw => sub { 'Hallo Welt!' }
; package main
; my $o1=new H::first::
; is($o1->hw,'Hallo Welt!')
; my $o2=$o1->new
; is($o2->hw,'Hallo Welt!')
# no method to change a method in version 0.61
; $o2->[$o2->_hw] = sub { 'Hello world!' }
; is($o2->hw,'Hello world!')