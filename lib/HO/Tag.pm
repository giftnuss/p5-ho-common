  package HO::Tag
# ***************
; our $VERSION='0.03'
# *******************
; use strict; use warnings

; use parent qw/
    HO::Object
    HO::mixin::attributes::autoload
  /

; use HO::class
    _method => string => sub
        { if( $_[0]->is_single_tag )
            { return $_[0]->_single_tag
            }
          else
            { return $_[0]->_double_tag
            }
        }

; sub _tag : lvalue
    { $_[0]->_thread->[0]
    }

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
    { return $_[0]->count < 1
    }

; sub _single_tag
    { my ($tag,@thread) = @{$_[0]->_thread}

    ; my $r = $_[0]->_begin_tag . $_[0]->_tag . $_[0]->attributes_string . $_[0]->_close_stag

    ;    $r .= ref($_) ? "$_" : $_ foreach @thread
    ; return $r
    }

; sub _double_tag
    { my ($tag,@thread) = @{$_[0]->_thread}

    ; my $r = $_[0]->_begin_tag . $_[0]->_tag . $_[0]->attributes_string() . $_[0]->_close_tag

    ; $r .= ref($_) ? "$_" : $_ foreach grep { defined } @thread

    ; $r .= $_[0]->_begin_endtag . $_[0]->_tag . $_[0]->_close_tag
    ; return $r
    }

# overwritten methods
; sub content
    { my ($tag,@content) = @{$_[0]->_thread}
    ; return @content
    }

; sub replace
    { my ($self,@args)  = @_
    ; @{$_[0]->_thread} = ($_[0]->_tag)
    ; $_[0]->insert(@args)
    }

; sub count
   { return @{$_[0]->_thread} - 1
   }

; 1

__END__

=head1 NAME

HO::tag

=head1 SYNOPSIS

...
