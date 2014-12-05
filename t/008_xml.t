; use strict; use warnings
; use Test::More tests => 3

; BEGIN { use_ok('HO::XML') }

; package X::ML
; use base 'HO::XML'

; use HO::class _method => 'namespace' => sub { 'xml' }

; my $tag = new X::ML('code')
; Test::More::is("$tag",'<xml:code />')

; Test::More::is($tag->namespace,"xml")


__END__

