  package HO::HTML
# ****************
; our $VERSION='0.01'
# *******************

; use HO::class
    _index => __is_single_tag => '$'
    
; sub is_single_tag : lvalue
   { if( defined $_[1] )
       { $_[0]->[&__is_single_tag] = $_[1] 
	    ; return $_[0] 
	    }
     else
	    { return $_[0]->[&__is_single_tag]
	    }
   }

# move this to HO::HTML::Tag
; require HO::class
; require Exporter  

; our @ISA = ('Exporter')
; our @TAGS
; our (@EXPORT_OK,@EXPORT)
  
; sub import
  { my ($pkg,%args)=@_
  ; if($args{'functional'})
      { local @EXPORT
      ; if(ref $args{'tags'} eq 'ARRAY')
	  { @EXPORT = @{$args{'tags'}}
	  }
	else
	  { @EXPORT = @TAGS
	  }
      ; __PACKAGE__->export_to_level(1,$pkg,@EXPORT)
      }
  }

; sub _make_tags
  { my $baseclass = caller(0)
  ; my %args = @_
  ; my @tags = @{$args{'tags'}}
  ; push @TAGS,@tags
	
  ; foreach my $tag (@tags)
      { HO::class::make_subclass
	    ( of => [ $baseclass ]
	    , shortcut_in  => 'HO::HTML'
	    , name         => $tag
	    , codegen      => $args{'codegen'}
      )}
  }
  
; package HO::HTML::Double
; use base qw/HO::tag HO::attr::autoload HO::insertpoint/
  
; our @TAGS = qw
  ( Html Head Title Body
    A Big Div P Pre Small Span Sub Sup
    Caption Colgroup Col Table Thead Tbody Tfoot Tr Th Td
    Ol Ul Li Dl Dd Dt
    Blockquote Q
    Button Fieldset Form Label Legend Option Select Textarea 
  )
  
; sub create_tags
  { HO::HTML::_make_tags
    ( tags    => $_[1]
    , codegen => sub 
        { my %args = @_; return sprintf <<'__PERL__'
	      
  sub init 
      { my ($self,@args)=@_
      ; $self->_is_single_tag(0)
      ; $self->insert("%s",@args)
      }

__PERL__
	, lc($args{'name'})
	}
    )
  }

; __PACKAGE__->create_tags(\@TAGS)
  
; package HO::HTML::Header
; use base qw/HO::tag HO::attr::autoload HO::insertpoint/

; our @TAGS = qw(H)

; HO::HTML::_make_tags(tags => \@TAGS
    , codegen =>
        sub { my %args = @_
	    ; 'sub init {my ($self,$level,@args)=@_'
	     .';$self->_is_single_tag(0)'
	     .';if(defined($level))' # no warnings if constructor call without args
	     .'    {return $self->insert("'.lc($args{'name'}).'".$level,@args)}'
             .'else{return $self}}'
	    }
    )
  
; package HO::HTML::Single
; use base qw/HO::tag HO::attr::autoload HO::insertpoint/
  
; our @TAGS = qw(Br Hr Img Input)

; sub _close_stag   () { ' >' } # inline

; HO::HTML::_make_tags(tags => \@TAGS
    , codegen =>
        sub { my %args = @_
	    ; 'sub init {my ($self,@args)=@_'
	     .';$self->_is_single_tag(1)'
	     .';$self->insert("'.lc($args{'name'}).'",@args)}'
	    }
    )

; 1

