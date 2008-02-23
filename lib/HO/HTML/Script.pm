  package HO::HTML::Script
# ************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; no warnings "void"

; use HO::common qw/node newline/
; use HO::HTML functional => [qw/Script/]

; our @ISA = 'HO::HTML'
; our @EXPORT
; our @EXPORT_OK = qw/Javascript JavascriptNC/
; our %EXPORT_TAGS = (all => \@EXPORT_OK)

# defines a script block
; sub Javascript
    { my (@args) = @_
    ; my $opts = { type => "text/javascript" }
    ; if(ref $args[0] eq 'HASH')
        { $opts =  {%$opts, %{shift @args}}
        }
    ; my $tag = Script()
    ; $tag->type($opts->{'type'}) if $opts->{'type'}
    
    ; unless($opts->{'nocomment'})
        { my $node = node(@args)
        ; $tag << "<!--//" << newline() << $node << newline() << "//-->" 
        ; $tag->insertpoint($node)
        }
    ; return $tag
    }
    
; sub JavascriptNC
    { my (@args) = @_
    ; my $opts = {}
    ; $opts = shift @args if(ref $args[0] eq 'HASH')
    ; $opts->{'nocomment'} = 1
    ; unshift @args, $opts
    ; return Javascript(@args)
    }

; 1

__END__

; use strict
; use warnings

; package HO::HTML::Script

; use HO::Tag
; use HO::Exporter
; use base ('HO::Tag','HO::Exporter');

; use Data::Dumper

; our $VERSION='0.0.2';
; our @EXPORT

; sub import
   { my $class=shift
   ; my %p=( namespace => '', functional => 0, @_)
   ; my $ns=$p{namespace}; $ns.='::' if $ns
   
   ; my $t='Script'
   ; my $pack=$ns.$t
   ; $class->create_tag($pack,'HO::HTML::Script',lc $t)
   ; $class->register( \@EXPORT, $t, $pack ) if $p{functional}
   
   ; $t='Noscript'
   ; $pack=$ns.$t
   ; $class->create_tag($pack,'HO::Tag::Double',lc $t)
   ; $class->register( \@EXPORT, $t, $pack ) if $p{functional}
   }

; sub new
   { my $class=shift
   ; $class->SUPER::new(shift, "<!--//\n" , @_ )
           ->type('text/javascript');
   }

; sub src
   { my $obj=shift
   ; $obj->set_attribute('src',shift);
   ; splice( @{$obj->_thread},1,1);
   ; $obj
   }

; sub get
   { my $self=shift
   ; my $r
   ; if( exists $self->_attributes->{'src'} )
      { $r=(bless $self, 'HO::Tag::Double')->get() }
     elsif( exists $self->_attributes->{'nocomment'} )
      { splice( @{$self->_thread},1,1 )
      ; delete $self->_attributes->{'nocomment'}
      ; $r=(bless $self, 'HO::Tag::Double')->get()
      }
     else
      {	$self->insert("\n//-->")
      ; $r=(bless $self, 'HO::Tag::Double')->get()
      }
   ; $r
   }
   
; sub nocomment
   { my $self=shift
   ; $self->bool_attribute("nocomment")
   ; $self
   }

; 1

__END__
   
