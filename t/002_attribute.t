# -*- perl -*-

# t/002_attribute.t - get and set attribute

use Test::More tests => 7;

use HO::attr;

my $h=new HO::attr;

$h->set_attribute('undef1');
ok(!defined $h->get_attribute('undef1'),"bool attribute set by API call");


$h->undef2;
ok(!defined $h->get_attribute('undef2'),"bool attribute set by AUTOLOAD");


$h->set_attribute('text1','');
is($h->get_attribute('text1'),'',"attribute with empty value");


$h->set_attribute('text2','Hierachical Objects');
is($h->get_attribute('text2'),'Hierachical Objects',"attribute with string value");

$h->text2("Object Hierarchy");
is($h->get_attribute('text2'),'Object Hierarchy','overwrite attribute by AUTOLOAD method');

$b=$h->set_attribute('text2');
isa_ok($b,"HO","return value is an object");
is_deeply($b,$h,"returning self");


