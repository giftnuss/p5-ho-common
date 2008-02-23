  package HO::HTML::element
# *************************
; our $VERSION='0.01'
# *******************

; use base ( 'HO::tag'
           , 'HO::insertpoint'
           , 'HO::HTML::attribute'
           , 'HO::attr::autoload'
           )

; use HO::class
    _lvalue => _is_single_tag => '$'

; use subs qw/init/

; sub _close_stag   () { ' >' } # inline

; sub is_single_tag 
    { return $_[0]->_is_single_tag
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

; package HO::HTML::element::header
# *********************************
; our $VERSION='0.01'
# *******************

; use base ('HO::HTML::element')

; use HO::class
    _rw => level => '$' 
    
; sub default_level
    { my ($self) = @_
    ; return undef unless $self->_tag
    ; return ($self->_tag =~ /.*(\d+)(_.*)?$/ && $1) || 1
    }

; 1

__END__


    