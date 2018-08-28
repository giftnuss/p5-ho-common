  use strict; use warnings
  ; use Test::More tests => 13
  ; use Test::Exception
  ; use Data::Dumper
  ; use 5.010

; BEGIN {
        ; use_ok('HO::ClassBuilder')
        }

; my $builder = HO::ClassBuilder->new
    ( name => 'Gerade'
    , namespace => ['Eben']
    )

; is($builder->get_class_name, 'Eben::Gerade', 'class name')

; { no strict 'refs'; ok(! %{$builder->get_class_name.'::'},"class is not defined") }

; ok($builder->build)

; { no strict 'refs'; ok(%{$builder->get_class_name.'::'},"class is defined"); }
# can not be checked as plain var
; { no strict 'refs'; is(${"Eben::Gerade::VERSION"}, '0.01',"Default version"); }


; $builder = HO::ClassBuilder->new
    ( name => 'Gerade'
    , namespace => ['Geometrie','Struktur']
    , parents => ['Eben::Gerade']
    , version => 0.02
    )

; is($builder->get_class_name, 'Geometrie::Struktur::Gerade', 'class name')
; is_deeply([$builder->parents],['Eben::Gerade'],'parents')

; ok($builder->build)

; { no strict 'refs'; is_deeply(\@{$builder->get_class_name . '::ISA'}, ['Eben::Gerade'],'simple @ISA test') }
; { no strict 'refs'; is(${"Geometrie::Struktur::Gerade::VERSION"}, '0.02',"given version"); }

; ok( Geometrie::Struktur::Gerade->isa('Eben::Gerade'),'isa check' )

; $builder = HO::ClassBuilder->new

; throws_ok { $builder->get_class_name }
      qr/ClassBuilder needs at least a name to build a class\./;
