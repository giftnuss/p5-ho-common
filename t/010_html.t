  use strict; use warnings
  ; use Test::More tests => 7
  ; use Data::Dumper
  
  ; BEGIN 
      { require_ok('HO::HTML')
      ; is(0+HO::HTML::seq_props(),@HO::HTML::elements/2)
      ; is(0+HO::HTML->list_names(),@HO::HTML::elements/2)
      #; warn Dumper([HO::HTML->list_names])
      ; use_ok('HO::HTML')
      ; my $init = $HO::HTML::inits[0]
      ; my $code = $init->(1,'img')
      ; my $meth = $code->()
      ; ok print $meth
      ; use_ok('HO::HTML', tags => ['a'], functional => 1)
      }
      
  ; is("".A(),'<a></a>')
