# -*- perl -*-

# t/005_overload.t - test overload with example HTML module

use Test::More tests => 2;

use strict;
no warnings 'void';

use HO::HTML;

my $html = HO::HTML::Html();
my $head = HO::HTML::Head();
my $body = HO::HTML::Body();

$html<<$head<<$body;
is ($html,'<html><head></head><body></body></html>');

my $para = HO::HTML::P();
my $img  = HO::HTML::Img();
$body<<($para<<$img);
is ($body,'<body><p><img /></p></body>');

