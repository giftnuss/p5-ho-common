
use strict;
use warnings;
no warnings 'void';

use Test::More tests => 7;
use HO::HTML;

my $html=HO::HTML::Html;
my $head=HO::HTML::Head;
my $body=HO::HTML::Body;
my $p   =HO::HTML::P;
my $h   =HO::HTML::H(1);

$html<<$head<<$body;
is("$html",'<html><head></head><body></body></html>');

$body**$p**$h;
is("$body",'<body><p><h1></h1></p></body>');

is("$h",'<h1></h1>');

$h=HO::HTML::H(6);
$p=HO::HTML::P;
my $i=HO::HTML::Img;
$h<<$p**$i;
is("$h",'<h6><p><img ></p></h6>');

$h=HO::HTML::H(3,'eins');
$p=HO::HTML::P()<<'zwei';
is($h+$p."",'<h3>eins</h3><p>zwei</p>');

is($h x 2,'<h3>eins</h3><h3>eins</h3>');

$h=2*$h;
is("@$h",'<h3>eins</h3> <h3>eins</h3>');





