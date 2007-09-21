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

; sub make_subclass
  { my %args = @_
  ; $args{'of'}   ||= [ "".caller(1) ]
  ; $args{'name'} || return
  ; $args{'in'}   ||= $args{'of'}->[0]
  ; $args{'code'} ||= $args{'codegen'} ? $args{'codegen'}->(%args) : ''
  # optional shortcut_in
      
  ; my $code = 'package '.$args{'in'}.'::'.$args{'name'}.';'
             . 'our @ISA = qw/'.join(' ',@{$args{'of'}}).'/;' . $args{'code'}
      
  ; if($args{'shortcut_in'})
      { $code .= 'package '.$args{'shortcut_in'}.';'
	       . 'sub '.$args{'name'}.' { new '.$args{'in'}.'::'.$args{'name'}.'(@_) }'
      }
  ; eval $code
  ; die $@ if $@
  }

; 1

__END__


