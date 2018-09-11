
# teste HO::attr
; use strict
; use Test::More tests => 4

; BEGIN
  { use_ok('HO::Object')
  ; use_ok('HO::mixin::attributes')
  }

; package HOx::RT

; use HO::mixin qw/HO::mixin::attributes/

; use parent qw/HO::Object/

; use HO::class

; package main

; my $a=new HOx::RT::(1..3)

; $a-> hallo = "welt"

; is("$a",'123')
; is($a->hallo,"welt")


