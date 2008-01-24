; use strict; use warnings
; use Test::More tests => 1

; BEGIN { use_ok('HO::XML') }




__END__

;   package HO::XML::Export
# ************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8

; use HO::Tag
; use HO::Exporter
; our @ISA=qw(HO::Exporter)

; our @EXPORT

; our %packages = (
     'HO::Tag::Double'
       => [ 'Export'       # root - Element
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
                       , 'Title'      # Überschrift
                       , 'Sortpos'    # Position 1..10
                       , 'Sortorder'  # ASC oder DESC / auf- oder absteigend sortieren
                       , 'Grouppos'   # Gruppierung 1..3
                       , 'Fieldpos'   # für Darstellung übereinander
                       , 'Makro'      # für Textersetzungen
                      #, 'Type'       # Feldtyp
                , 'Data'         # Daten
                   , 'Row'
                      , 'Item'
          ]
     )