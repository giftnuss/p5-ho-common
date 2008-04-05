  package HO::tag
# ***************
; use base 'HO::attr'
; our $VERSION = $HO::VERSION
# ***************************
; use strict; use warnings
  
; sub _tag : lvalue
    { $_[0]->_thread->[0] }
    
; sub tag
    { my ($self,$val) = @_
    ; if(defined($val))
        { $self->_tag = $val
        ; return $self
        }
      else
        { return $self->_tag
        }
    }

; sub _begin_tag    () { '<'   } # inline
; sub _close_tag    () { '>'   } # inline
; sub _close_stag   () { ' />' } # inline
; sub _begin_endtag () { '</'  } # inline

; sub is_single_tag
    { return $_[0]->count <= 1
    }

; sub string
    { if( $_[0]->is_single_tag )
        { return $_[0]->_single_tag }
      else
        { return $_[0]->_double_tag }
    }

; sub _single_tag
    { my ($tag,@thread)=$_[0]->content
	  
    ; my $r = $_[0]->_begin_tag . $_[0]->_tag . $_[0]->attributes_string . $_[0]->_close_stag
	  
    ;    $r .= ref($_) ? "$_" : $_ foreach @thread
    ; return $r
    }

; sub _double_tag
    { my ($tag,@thread)=$_[0]->content

    ; my $r = $_[0]->_begin_tag . $_[0]->_tag . $_[0]->attributes_string() . $_[0]->_close_tag

    ; $r .= ref($_) ? "$_" : $_ foreach @thread

    ; $r .= $_[0]->_begin_endtag . $_[0]->_tag . $_[0]->_close_tag
    ; return $r
    }

# overwritten methods
; sub replace
    { my ($self,@args)  = @_
    ; @{$_[0]->_thread} = ($_[0]->_tag,@args)
    }

; 1

__END__

=head1 NAME

HO::tag
  
=head1 SYNOPSIS

...
