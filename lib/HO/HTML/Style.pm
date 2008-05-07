  package HO::HTML::Style
# ***********************
; our $VERSION='0.01'
# *******************
; use strict; use warnings

; use HO::HTML functional => [qw/Link Style/]

; sub Stylefile
    { my (%args)= @_
    ; my $file  = $args{'src'} || $args{'href'}
    ; my $media = $args{'media'} || 'screen'
    ; my $link = Link()->rel('stylesheet')->type('text/css')
    ; $link->href($file) if $file
    ; $link->media($media) if $media
    ; return $link
    }

; 1

__END__

; use HO::Tag
; use HO::Exporter
; use base ('HO::Tag','HO::Exporter')

; our $VERSION='0.021'
; our @EXPORT

; sub import
  { my $class=shift
  ; my %p=( namespace => '', functional => 0, @_)
  ; my $ns=$p{namespace}; $ns.='::' if $ns
   
  ; my $t='Style'
  ; my $pack=$ns.$t
  ; $class->create_tag($pack,$class,lc $t)
  ; $class->register( \@EXPORT, $t, $pack ) if $p{functional}
  }
  
; sub new
  { my $class=shift
  ; $class->SUPER::new(shift(),"\n",@_)->type("text/css")
  }
  
; sub Style
  { __PACKAGE__->new('style',@_)
  }

; sub src
  { my $obj=shift
  ; $obj->_thread->[0]="link"
  ; $obj->href(shift)->rel('stylesheet')
  ; splice(@{$obj->_thread},1,1);
  ; $obj
  }
  
; sub get
  { my $self=shift
  ; if( exists $self->_attributes->{'href'} )
     { return (bless $self, 'HO::Tag::Double')->get() }
    else
     { return (bless $self, 'HO::Tag::Double')->get() }
  }
  
; 1
