# -*- perl -*-

# t/021_insertpoint.t - check module loading and the simple api

; use strict; use warnings
; use Test::More tests => 2
; no warnings 'void'

; BEGIN
    { use_ok('HO::HTML', tags => ['html','head','body','p','h1'], functional => 1);
    };

my $html = Html();
my $head = Head();
my $body = Body;
my $p    = P;

$html << $head << $body;
$html->insertpoint($body) << ($p << H1("Hallo Welt!"));

is("$html",'<html><head></head><body><p><h1>Hallo Welt!</h1></p></body></html>');
