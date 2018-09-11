# -*- perl -*-

# t/002_attribute.t - get and set attribute

use Test::More tests => 22;

BEGIN { use_ok('HO::mixin::attributes') };

my $h=new HO::mixin::attributes::;

$h->set_attribute('undef1');
ok(!defined $h->get_attribute('undef1')  , "bool attribute set by API call");
ok($h->has_attribute('undef1')           , "but attribute is set");

ok(!defined $h->undef2(),"get unknown attribute does not create the attribute");
ok(!$h->has_attribute('undef2')           , "attribute is here not set");

is_deeply($h->undef2(undef),$h,"\$self is returned by autoload setter");
ok(!defined $h->get_attribute('undef2')  , "bool attribute set by AUTOLOAD");
ok($h->has_attribute('undef2')           , "attribute is also set");

ok(!$h->has_attribute('notset')          , "but this is not set");

$h->set_attribute('text1','');
is($h->get_attribute('text1'),'',"attribute with empty value");


$h->set_attribute('text2','Hierachical Objects');
is($h->get_attribute('text2'),'Hierachical Objects',"attribute with string value");

$h->text2("Object Hierarchy");
is($h->get_attribute('text2'),'Object Hierarchy','overwrite attribute by AUTOLOAD method');

$b=$h->set_attribute('text2');
isa_ok($b,"HO::mixin::attributes");
is_deeply($b,$h,"returning self");

my $n=new HO::mixin::attributes::;
$n->get_attribute("hallo") = "welt";
ok($n->has_attribute('hallo'),"attr exists get_attribute lvalue");
is($n->get_attribute('hallo'),'welt','attr set with lvalue get_attribute');
is($n->attributes_string,' hallo="welt"','stringify 1');

my $a=new HO::mixin::attributes::;
$a->hallo = "welt";
ok($a->has_attribute('hallo'),"attr exists with lvalue autoload");
is($a->get_attribute('hallo'),'welt','attr set with lvalue autoload');
is($a->hallo,"welt",'get attr via autoload');
is($a->attributes_string,' hallo="welt"','stringify 2');

# *******************************************************************

package My::HTML::Element::Special;

use HO::HTML tags => ['Img'];
push our @ISA, 'HO::HTML::Element::Img';

sub init {
    my ($self,@args) = @_;
    $self->SUPER::init(@args);
    $self->set_attribute('style','width:400px;');
    $self->set_attribute('class','special-img');
    $self;
}

package main;

my $img = new HO::HTML::Element::Img::;

my $special = new My::HTML::Element::Special::;

$special->rm_attribute('style');

is "$special","<img class=\"special-img\" >";


