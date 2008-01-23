use strict; use warnings;
use Test::More tests => 2;

use HO::HTML functional => 1;

is(A('MFG')."",'<a>MFG</a>');
is(Img()->src('./test.jpg')."",'<img src="./test.jpg" >');

