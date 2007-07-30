  package HO::class
# *****************
; our $VERSION=$HO::VERSION
# *************************
; use strict; use warnings

; require HO::accessor

; sub import
    { my ($package,@args)=@_
    ; my $makeconstr = 1
    ; my $class = caller
    ; my @acc
    ; my @methods

    ; while(@args)
        { my $action = lc(shift @args)
        ; if($action eq 'method')
            { my ($name,$code) = splice(@args,0,2)
            ; push @acc, "_$name",'$'
            ; push @methods, $name, $code
            }
          elsif($action eq 'accessor')
            { push @acc, splice(@args,0,2)
            ;
            }
          elsif($action eq 'noconstructor')
            { $makeconstr = 0
            }
          else
            { die "Unknown action '$action' for $package."
            }
        }
    ; if($makeconstr)
        { local $HO::accessor::class = $class 
        ; import HO::accessor \@acc 
        }

    ; { no strict 'refs'
      ; while(@methods)
          { my ($name,$code)=splice(@methods,0,2)
          ; my $idx = _value_of HO::accessor "_$name"
          ; *{join('::',$class,$name)} = sub 
               { my $self = shift
               ; $self->[$idx] ? $self->[$idx]->($self,@_)
                               : $code->($self,@_)
               } 
          }
      }
    }

; sub method

; sub constructor

; 1

__END__


