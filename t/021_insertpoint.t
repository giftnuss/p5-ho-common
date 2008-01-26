# -*- perl -*-

# t/021_insertpoint.t - check module loading and the simple api

; use Test::More tests => 4

; BEGIN
    { use_ok('HO::tag');
      use_ok('HO::insertpoint');
      use_ok('HO::HTML');
      push @HO::HTML::element::ISA,'HO::insertpoint'
    };

my $html=HO::HTML::Html;
my $head=HO::HTML::Head;
my $body=HO::HTML::Body;
my $p   =HO::HTML::P;
my $h   =HO::HTML::H(1);

$html << $head << $body;
$html->insertpoint($body) << $p;

is("$html",'<html><head></head><body><p></p></body></html>');