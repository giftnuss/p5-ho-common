  package HO::HTML::attribute
# ***************************
; our $VERSION='0.01'
# *******************

; sub style
    { my ($self,@args) = @_
    ; if(@args)
        { (my $style = $self->get_attribute('style'))
            and unshift @args,$style
        ; return $self->set_attribute('style',join(";",@args))
        }
      else
        { return $self->get_attribute('style')
        }
    }

; sub class
    { my ($self,@args) = @_
    ; if(@args)
        { (my $class = $self->get_attribute('class'))
            and unshift @args,$class
        ; return $self->set_attribute('class',join(" ",@args))
        }
      else
        { return $self->get_attribute('class')
        }
    }

################################################
# testing is a mess without ordered attributes
################################################
; our @ATTRIB = qw/id title class style/

; sub attributes_string
    { my ($self) = @_
    ; my $r    = ""
    ; my %attr = %{$self->_attributes}

    ; foreach my $key (@ATTRIB)
        { if($self->has_attribute($key))
            { $r .= $self->write_attribute($key,delete($attr{$key}))
            }
        }
    ; foreach my $key (keys %attr)
        { $r .= $self->write_attribute($key,$attr{$key})
        }
    ; return $r
    }

; 1

__END__

