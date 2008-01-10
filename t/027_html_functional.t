
use Test::More tests => 1;

use HO::HTML functional => 1;

is(A('MFG')->get,'<a>MFG</a>');
