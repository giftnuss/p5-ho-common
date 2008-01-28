use strict; use warnings;
use Test::More tests => 3;

use HO::HTML functional => 1;

is_deeply([HO::HTML::->list_loaded],[HO::HTML::->list_names]);

is(A('MFG')."",'<a>MFG</a>');
is(Img()->src('./test.jpg')."",'<img src="./test.jpg" >');

