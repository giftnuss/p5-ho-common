  package HO::XML
# ***************
; use strict; use warnings
# ************************
; use base qw(HO::tag HO::insertpoint)

# Am besten wäre es eine Möglichkeit zu haben den default code einer Methode
# ebenfalls noch ändern zu können.
; use HO::class
    _method => 'namespace^cs' => sub {undef}
    
; sub _single_tag
    { my ($self) = @_
    ; my ($tag,@thread) = $self->content
	  
    ; my $r = $self->_begin_tag
    ; $r   .= $self->namespace . ':' if $self->namespace
    ; $r   .= $self->_tag . $self->attributes_string . $self->_close_stag
    ; return $r
    }
    
; sub _double_tag
    { my ($self) = @_
    ; my ($tag,@thread)=$_[0]->content

    ; my $begin = $self->_begin_tag
    ; my $end   = $self->_begin_endtag
    ; if($self->namespace)
        { $begin .= $self->namespace . ':'
        ; $end   .= $self->namespace . ':'
        } 
    ; $begin .= $self->_tag . $self->attributes_string() . $self->_close_tag
    ; $end   .= $_[0]->_tag . $_[0]->_close_tag
    ; $begin .= ref($_) ? "$_" : $_ foreach @thread

    ; return $begin.$end
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

