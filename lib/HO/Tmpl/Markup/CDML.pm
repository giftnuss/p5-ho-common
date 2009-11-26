  package HO::Tmpl::Markup::CDML
# ******************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; use utf8
; no warnings "void"

; use Carp ()

# Nicht übertragene Features der alten CDML Klasse
# - nachträgliches Ändern des Encoding

; use base 'Exporter'
; our @EXPORT_OK = ('Cdml')

; sub Cdml { return 'HO::Tmpl::Markup::CDML' }

; our @baseclasses =
    ( 'HO::Tmpl::Markup::CDML::element::single'
    , 'HO::Tmpl::Markup::CDML::element::double'
    , 'HO::Tmpl::Markup::CDML::element::choice'
    , 'HO::Tmpl::Markup::CDML::element::valuelist'
    )

; our %current =
    ( action      => 'Action'       # Zuletzt ausgeführte Datenbank Aktion
    , datasource  => 'Database'     # meist das gleiche wie ein DB-Table/Domain
    , date        => 'Date'         # Aktuelles Datum
    , error       => 'Error'        # Fehlercode der letzten Aktion
    , foundcount  => 'FoundCount'   # Aktuell aufgerufene Datensätze
    , layout      => 'Layout'       # eine beschränkte Auswahl von Feldern
    , recid       => 'RecID'        # System interne Record ID
    , recpos      => 'RecordNumber' # Aktuelle Position in der Auswahl
    , recordcount => 'RecordCount'  # Anzahl der vorhandenen Records
    , skip        => 'Skip'         # Wieviele Datensätze der Auswahl auslassen
    , time        => 'Time'         # Aktuelle Uhrzeit
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
    { my ($self,@args) = @_
    ; return $baseclasses[2]->new(@args)
    }

; sub valuelist
    { my ($self,$opts,@args) = @_
    ; my $field = $opts->{'field'}
        || Carp::croak "CDML: No field specified for valuelist."
    ; my $listname = $opts->{'listname'}

    ; my $markup = $baseclasses[3]->new('ValueList',@args)
    ; $markup->set_field($field)
    ; $markup->set_listname($listname) if $listname

    ; return $markup
    }

; sub valuelistitem
    { return $baseclasses[0]->new('ValueListItem')    
    }

; sub valuelistchecked
    { return $baseclasses[0]->new('ValueListChecked')
    }

; sub inlineaction
    { return new HO::('[FMP-InlineAction]IA - is a todo.[/FMP-InlineAction]')
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
; use base 'HO::Tmpl::Markup::CDML::element::double'

# NOTE: here are no array refs allowed as arguments
# Maybe add a check if array refs contain an even
# number of arguments.
; my $custom_insert = sub
    { my ($self,@args) = @_

    ; if(@args%2) # an else exists
        { $self->set_default_choice( pop @args )
        }
    ; push @{$self->_thread}, @args
    ; return $self
    }

; sub set_default_choice
    { my ($self,$else) = @_
    ; if($self->has_attribute('default'))
        { $self->get_attribute('default')->insert($else)
        }
      else
        { $self->set_attribute('default',new HO($else))
        }
    ; return $self
    }

; sub init
    { my ($self,@args) = @_
    ; my $class = ref $self

    ; my $idx = HO::accessor::_value_of($class,"_insert")
    ; $self->[$idx] = $custom_insert

    ; return $self->insert(@args)
    }

; sub string
    { my $self=shift
    ; my $r   = ""
    ; my @list = @{$self->_thread}
    ; my ($c,$i) = splice(@list,0,2)

    ; $r .= $self->_begin_tag . 'If: ' . $c . $self->_close_tag . $i

    ; while(@list)
        { ($c,$i) = splice(@list,0,2)
        ; $r .=  $self->_begin_tag . 'ElseIf: ' . $c . $self->_close_tag . $i
        }

    ; if($self->has_attribute('default'))
        { $r .= $self->_begin_tag . 'Else' . $self->_close_tag 
              . $self->get_attribute('default')
        }
        
    ; $r .= $self->_begin_endtag . 'If' . $self->_close_tag 
    ; return $r
    }

; package HO::Tmpl::Markup::CDML::element::valuelist
# **************************************************
; our $VERSION='0.01'
# *******************
; use base 'HO::Tmpl::Markup::CDML::element::double'

; sub set_field
    { my ($self,$field) = @_
    ; return $self->set_attribute('field' => $field)
    }

; sub set_listname
    { my ($self,$listname) = @_
    ; return $self->set_attribute('listname' => $listname)
    }

; sub attributes_string
    { my ($self) = @_
    ; my $field  = $self->get_attribute('field')
    ; my $list   = $self->get_attribute('listname')

    ; return ": $field" . ($list ? ", List=$list" : '')
    }

__END__


    # The FileMaker Dynamic Markup Language or FDML was a markup language used in 
    # the earlier versions of FileMaker introduced in 1998. It is also often 
    # referred to as Claris Dynamic Markup Language or CDML, named after the old 
    # company Claris.
    #
    # from wikipedia

