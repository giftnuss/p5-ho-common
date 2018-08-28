  use strict; use warnings
  ; use Test::More tests => 4
  ; use Data::Dumper

  ; BEGIN
      { use_ok('HO::HTML::Element')
      ; use_ok('HO::HTML::Element::Heading')
      }

  ; my $e = HO::HTML::Element->new
  ; my $h = HO::HTML::Element::Heading->new(1)

  ; ok($e->can('_is_single_tag'))
  ; ok($h->can('_is_single_tag'))

