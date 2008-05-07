use strict; use warnings;
use Test::More tests => 4;

BEGIN
    { use_ok('HO::HTML::Script', functional => ['Javascript','JavascriptNC'])
    }
    
is_deeply([HO::HTML::->list_loaded],[HO::HTML::->list_names]);

; is("".Javascript()."\n",<<__TEXT__)
<script type="text/javascript"><!--//

//--></script>
__TEXT__

; is("".Javascript('var here = "test";')."\n",<<__TEXT__)
<script type="text/javascript"><!--//
var here = "test";
//--></script>
__TEXT__
