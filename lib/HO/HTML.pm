  package HO::HTML
# ****************
; our $VERSION='0.01'
# *******************

; require HO::class

; sub _make_tags
  { my $baseclass = caller(0)
  ; my %args = @_
  ; my @tags = @{$args{'tags'}}
	
  ; foreach my $tag (@tags)
      { HO::class::make_subclass
	    ( of => [ $baseclass ]
	    , shortcut_in  => 'HO::HTML'
	    , name         => $tag
	    , codegen      => $args{'codegen'}
      )}
  }
  
; package HO::HTML::Double
; use base 'HO::tag'
  
; our @TAGS = qw
  ( Html Head Title Body
    A Big Div P Pre Small Span Sub Sup
    Caption Colgroup Col Table Thead Tbody Tfoot Tr Th Td
    Ol Ul Li Dl Dd Dt
    Blockquote Q
    Button Fieldset Form Label Legend Option Select Textarea 
  )
  
; HO::HTML::_make_tags(tags => \@TAGS
    , codegen =>
        sub { my %args = @_
	    ; 'sub init {my ($self,@args)=@_'
	     .';$self->_is_single_tag(0)'
	     .';$self->insert("'.lc($args{'name'}).'",@args)}'
	    }
    )
  
; package HO::HTML::Header
; use base 'HO::tag'

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
; use base 'HO::tag'
  
; our @TAGS = qw(Br Hr Img Input)

; HO::HTML::_make_tags(tags => \@TAGS
    , codegen =>
        sub { my %args = @_
	    ; 'sub init {my ($self,@args)=@_'
	     .';$self->_is_single_tag(1)'
	     .';$self->insert("'.lc($args{'name'}).'",@args)}'
	    }
    )

; 1

