  use strict; use warnings
  ; use Test::More tests => 6
  ; use Data::Dumper

  ; BEGIN
      { require_ok('HO::HTML')
      ; is(0+HO::HTML::seq_props(),@HO::HTML::elements/2)
      ; is(0+HO::HTML->list_names(),@HO::HTML::elements/2)
      ; use_ok('HO::HTML', tags => ['a','h1'], functional => 1)
      }

  ; is("".A(),'<a></a>')
  ; is("".H1(),'<h1></h1>')
