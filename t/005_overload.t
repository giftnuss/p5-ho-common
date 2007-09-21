# -*- perl -*-

# t/005_overload.t - test overload with example HTML module

use Test::More tests => 2;

use strict;
no warnings 'void';

use HO::HTML;

my $html = new Html();
my $head = new Head();
my $body = new Body();

$html<<$head<<$body;
is ($html->get,'<html><head></head><body></body></html>');

my $para = new P();
my $img  = new Img();
$body<<($para<<$img);
is ($body->get,'<body><p><img /></p></body>');

