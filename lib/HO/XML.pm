  package HO::XML
# ***************
; use strict; use warnings
# ************************
; use base qw(HO::tag HO::insertpoint)

# Am besten wäre es eine Möglichkeit zu haben den default code einer Methode
# ebenfalls noch ändern zu können.
; use HO::class
    _method => namespace => sub {undef}
    
; sub _single_tag
    { my ($self) = @_
    ; my ($tag,@thread)=$_[0]->content
	  
    ; my $r = $_[0]->_begin_tag
    ; $r .= $self->namespace if $self->namespace
    . $_[0]->_tag . $_[0]->attributes_string . $_[0]->_close_stag
	  
    ;    $r .= ref($_) ? "$_" : $_ foreach @thread
    ; return $r
    }
    


    
; 1

__END__


; sub create_tag
    { my ($class,$pack,$base,$tag)=@_
    ; return if $defined{$pack}
    ; eval qq~ package $pack; our \@ISA = qw($base)
             ; sub new { shift()->SUPER::new("$tag",\@_) }
             ~
    ; $defined{$pack}++
    }

