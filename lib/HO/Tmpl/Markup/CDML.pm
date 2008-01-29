  package HO::Tmpl::Markup::CDML
# ******************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8
; no warnings "void"

; require Carp

# Nicht übertragene Features der alten CDML Klasse
# - nachträgliches Ändern des Encoding

; use base 'Exporter'
; our @EXPORT_OK = ('Cdml')

; sub Cdml { return 'HO::Tmpl::Markup::CDML' }

; our @baseclasses =
    ( 'HO::Tmpl::Markup::CDML::element::single'
    , 'HO::Tmpl::Markup::CDML::element::double'
    , 'HO::Tmpl::Markup::CDML::element::choice'
    )

; our %current =
    ( date        => 'Date'         # Aktuelles Datum
    , error       => 'Error'        # Fehlercode der letzten Aktion
    , foundcount  => 'FoundCount'   # Aktuell aufgerufene Datensätze
    , recid       => 'RecID'        # System interne Record ID
    , recpos      => 'RecordNumber' # Aktuelle Position in der Auswahl
    , recordcount => 'RecordCount'  # Anzahl der vorhandenen Records
    , skip        => 'Skip'         # Wieviele Datensätze der Auswahl auslassen
    , action      => 'Action'       # Zuletzt ausgeführte Datenbank Aktion
    , datasource  => 'Database'     # meist das gleiche wie ein DB-Table/Domain
    , layout      => 'Layout'       # eine beschränkte Auswahl von Feldern
    )

; sub current
    { my ($self,$tag,@args) = @_
    ; $tag = lc($tag)
    ; my $name = "Current" . ($current{$tag} || do
        { Carp::croak "CDML: Invalid tag '$tag' in method current." })
    ; return $baseclasses[0]->new($name)
    }
    
# FIXME: Die Dokumentation  von CDML ist nicht ganz klar
; sub token
    { my ($self,%args) = @_
    ; my $id = $args{'nr'} || $args{'id'} || ''
    ; my $enc = $args{'encode'} || 'Raw'
    ; my $name = "CurrentToken" . ($id ? ": $id, $enc" : ": $enc")
    ; return $baseclasses[0]->new($name)
    }
    
; sub recordset
    { my ($self,@args) = @_
    ; return $baseclasses[1]->new('Record',@args)
    }
    
; sub portal
    { my ($self,$opts,@args) = @_
    ; my $name = $opts->{'name'} || Carp::croak "CDML: No name specified for portal."
    ; my $markup = $baseclasses[1]->new('Portal',@args)
    ; return $markup->set_tag_param($name)
    }
    
; sub field
    { my ($self,%args) = @_
    ; my $name = $args{'name'} || Carp::croak "CDML: No name specified for a field."
    ; my $enc  = $args{'encode'} || 'Raw'
    ; return $baseclasses[0]->new(sprintf("%s: %s, %s",'Field',$name,$enc))
    }
    
; our %client = 
    ( address  => 'Address'
    , ip       => 'IP'
    , type     => 'Type'     # UserAgent-Identifikation
    , username => 'UserName'
    , password => 'Password'
    )
    
; sub client
    { my ($self,$info) = @_
    ; $info = $client{lc($info)} || Carp::croak "CDML: Unknown client info type '$info'."
    ; return $baseclasses[0]->new("Client$info")
    }
    
; sub choice
    { my ($self,%args) = @_
    ; return $baseclasses[2]->new(%args)
    }
    
; package HO::Tmpl::Markup::CDML::element
# ***************************************
; our $VERSION='0.03'
# *******************

; use base 'HO::tag'

; sub _begin_tag    () { '[FMP-' }  # inline
; sub _close_tag    () { ']' }      # inline
; sub _close_stag   () { ']' }      # inline
; sub _begin_endtag () { '[/FMP-' } # inline

; sub set_tag_param
    { my ($self,$param) = @_
    ; return $self->set_attribute('param' => $param)
    }

; sub attributes_string
    { my ($self) = @_
    ; my $param  = $self->get_attribute('param')
    ; return $param ? ": $param" : '' 
    }

; package HO::Tmpl::Markup::CDML::element::single
# ***********************************************
; our $VERSION=$HO::Tmpl::Markup::CDML::element::VERSION
# ******************************************************
; use base 'HO::Tmpl::Markup::CDML::element'

; sub is_single_tag () { 1 }

; package HO::Tmpl::Markup::CDML::element::double
# ***********************************************
; our $VERSION=$HO::Tmpl::Markup::CDML::element::VERSION
# ******************************************************
; use base 'HO::Tmpl::Markup::CDML::element'

; sub is_single_tag () { 0 }

; package HO::Tmpl::Markup::CDML::element::choice
# ***********************************************
; our $VERSION='0.01'
# *******************
; use base 'HO::structure'

; use HO::common qw/node/

; __PACKAGE__->auto_slots

; sub init
    { my ($self,%args) = @_
    ; my @st   = node()->copy(3)
    ; $st[1] << $args{'Condition} if $args{'Condition'}
    ; $st[2] << $args{'If}        if $args{'If'}
    
    ; $st[0] << '[FMP-If: '  << $st[1] << ']' 
                             << $st[2] << '[/FMP-If]'
    
    ; my @slot = qw(Condition If)
    
    ; foreach my $s ( 0..$#slot )
        { $self->set_area($slot[$s],$st[$s+1])
        }
        
    ; return $self->set_root($st[0])
    }
    
; # Mache morgen weiter mit super Duper choice!!!
    
; package HO::Tmpl::Markup::CDML::element::IfElse
# ***********************************************
; our $VERSION='0.01'
# *******************
    
; __PACKAGE__->auto_slots

; sub init
    { my ($self,%args) = @_
    ; my @st   = node()->copy(4)
    ; $st[1] << $args{'Condition} if $args{'Condition'}
    ; $st[2] << $args{'If}        if $args{'If'}
    ; $st[3] << $args{'Else'}     if $args{'Else'}
    
    ; $st[0] << '[FMP-If: '  << $st[1] << ']' 
                             << $st[2]
             << '[FMP-Else]' << $st[3]**$else << '[/FMP-If]'
    
    ; my @slot = qw(Condition If Else)
    
    ; foreach my $s ( 0..$#slot )
        { $self->set_area($slot[$s],$st[$s+1])
        }
        
    ; return $self->set_root($st[0])
    }
    
; sub new
    { my ($class,$cond,$if,$else)=@_
    ; my $self = $class->HO::structure::new()
    ; my @st  =new HO()->copy(4)
    ; $st[0] << '[FMP-If: '  << $st[1]**$cond << ']' 
                             << $st[2]**$if
    ; $self->set_root($st[0])
    ; my @slot=qw(condition if else)
    ; foreach ( 0..$#slot )
        { $self->set_area($slot[$_],$st[$_+1]) }
    ; $self
    }

__END__

; package CDML
; use base 'HO::Tag'

# The FileMaker Dynamic Markup Language or FDML was a markup language used in 
# the earlier versions of FileMaker introduced in 1998. It is also often 
# referred to as Claris Dynamic Markup Language or CDML, named after the old 
# company Claris.
#
# from wikipedia

; our $VERSION='0.0.2'



; package CDML::Single
; use base 'CDML'

; sub get { $_[0]->HO::Tag::Single::get() }

; package CDML::Single::Encode
; use base 'CDML::Single'

; use Carp

; sub new
    { my ($class,$name,$encode,@arg)=@_
    ; my $pack = ref $class ? ref $class : $class
    ; $pack =~ s/.*:://
    ; my $self=$class->SUPER::new($pack,@arg) 
    ; $encode ||= 'Raw'
    ; carp unless $name
    ; $self->name($name)
    ; $self->encode($encode)
    }
    
; sub get_attributes
    { my $name  =$_[0]->get_attribute('name')
    ; my $encode=$_[0]->get_attribute('encode') || 'Raw'
    ; ": $name, $encode"
    }
    
; package CDML::Client
; use base 'CDML::Single'

; sub new
    { my ($class,$typ,@arg)=@_
    ; $class->SUPER::new("Client${typ}",@arg)
    }

; package CDML::Field
; use base 'CDML::Single::Encode'


# ; package CDML::FieldName
# ; use base 'CDML::Single::Encode'

; package CDML::Current
; use base 'CDML::Single'

; sub new
    { my ($class,$type,@arg)=@_
    ; $class->SUPER::new('Current'.$type,@arg)
    }
    
; package CDML::Token
; use base 'CDML::Current'

; sub new
    { my ($class,$num,@arg)=@_
    ; $class->SUPER::new("Token: $num",@arg)
    }
    
; package CDML::Double
; use base ('CDML','HO::Tag::Double')

; sub new
    { my ($class,@args)=@_
    ; $class = ref $class if ref $class
	; my $tag=$class->tagname
    ; unless($tag)
        { $tag = substr($class,-1*index(reverse($class),':')) }
    ; $class->SUPER::new($tag,@args)
    }
	
; sub tagname { undef }
    
; sub get     { HO::Tag::Double::get(@_) }
    
; package CDML::Record; use base 'CDML::Double'
; sub tagname () {'Record'}

; package CDML::ValueListItem; use base 'CDML::Single'
; sub new { shift()->SUPER::new('ValueListItem') }

; package CDML::ValueList; use base 'CDML::Double'
; sub new { my $self=shift()->SUPER::new() 
	      ; $self->name(shift())
          }
; sub get_attributes { ": ".$_[0]->name }

; package CDML::ValueListChecked; use base 'CDML::Single'
; sub new { shift()->SUPER::new('ValueListChecked') }

; 1

