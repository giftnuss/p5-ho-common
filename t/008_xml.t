; use strict; use warnings
; use Test::More tests => 6

; BEGIN { use_ok('HO::XML') }

; package X::ML
; use base 'HO::XML'

; use HO::class _method => 'namespace' => sub { 'xml' }

; my $tag = new X::ML('code')
; Test::More::is("$tag",'<xml:code />')

; Test::More::is($tag->namespace,"xml")

; package X::ML::Export

; use HO::ClassBuilder

; our @tags = (
          'Export'       # root - Element
             , 'Description'
                , 'Id'
                , 'Name'
                , 'Title'
                , 'Source'
                , 'Type'
                , 'Text'
             , 'Datasets'
                , 'Header'
                   , 'Column' # position ?
                       , 'Fieldid'
                      #, 'Name'
                      #, 'Title'      # Überschrift
                       , 'Sortpos'    # Position 1..10
                       , 'Sortorder'  # ASC oder DESC / auf- oder absteigend sortieren
                       , 'Grouppos'   # Gruppierung 1..3
                       , 'Fieldpos'   # für Darstellung übereinander
                       , 'Makro'      # für Textersetzungen
                      #, 'Type'       # Feldtyp
                , 'Data'         # Daten
                   , 'Row'
                      , 'Item'
     )

; for my $tag (@tags)
    { my $builder = HO::XML->get_class_builder(lc($tag),
        name => $tag,
        namespace => ['X','ML','Export','Element'])
    ; $builder->build
    ; $builder->make_shortcut( __PACKAGE__, $tag )
    }

package main;

use Data::Dumper;
use Package::Subroutine ();

; import Package::Subroutine:: 'X::ML::Export' =>
    qw/ Export
        Description
        Datasets
        Header
        Data
      /

; my $export = Export()
; isa_ok($export, 'HO::Tag')
; is("".Export(),'<export />')

; $export = Export(Description("Bla"),Datasets(Header(),Data()))
; is "$export", "<export><description>Bla</description>"
              . "<datasets><header /><data /></datasets></export>"

