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
    
; 1

__END__

