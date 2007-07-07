
use strict;
use warnings;
no warnings 'void';

use Test::More tests => 7;
use HO::HTML;

my $html=new Html;
my $head=new Head;
my $body=new Body;
my $p   = new P;
my $h   = new H(1);

$html<<$head<<$body;
is($html->get,'<html><head></head><body></body></html>');

$body**$p**$h;
is($body->get,'<body><p><h1></h1></p></body>');

is("$h",'<h1></h1>');

$h=new H(6);
$p=new P;
my $i=new Img;
$h<<$p**$i;
is("$h",'<h6><p><img /></p></h6>');

$h=new H(3,'eins');
$p=new P()<<'zwei';
is($h+$p."",'<h3>eins</h3><p>zwei</p>');

is($h x 2,'<h3>eins</h3><h3>eins</h3>');

$p=2*$h;
is("$p",'<h3>eins</h3><h3>eins</h3>');





