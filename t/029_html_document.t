use strict; use warnings;
use Test::More tests => 5;

BEGIN
    { use_ok('HO::HTML::Document')
    }
    
is_deeply([HO::HTML::->list_loaded],[HO::HTML::->list_names]);


; use Data::Dumper

; my $doc = HO::HTML::Document->new()

; isa_ok($doc,'HO::HTML::Document')
; ok($doc->isa('HO::structure'))

; is("$doc","\n<html>\n<head><title></title></head><body></body></html>\n")

