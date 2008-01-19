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
    ; my @acc         # all internal accessors
    ; my @methods     # method changeable on a per object base
    ; my @lvalue      # lvalue accessor
    ; my @r_          # common accessors

    ; while(@args)
        { my $action = lc(shift @args)
        ; my ($name,$type,$code)
        ;({ '_method' => sub
            { ($name,$code) = splice(@args,0,2)
            ; push @acc, "_$name",'$'
            ; push @methods, $name, $code
            }
          , '_index' => sub
            { ($name,$type) = splice(@args,0,2)
            ; push @acc, $name, $type
            }
          , '_lvalue' => sub
            { ($name,$type) = splice(@args,0,2)
            ; push @acc, "_$name", $type
            ; push @lvalue, $name
            }
          , '_rw' => sub
            { ($name,$type) = splice(@args,0,2)
            ; push @acc, "_$name", $type
            ; if(lc($args[0]) eq 'abstract')
                { shift @args
                }
              else
                { push @r_, $name => sub
                    { my $idx = _value_of HO::accessor "_$name"
                    ; return HO::accessor::rw($name,$idx,$type)
                    }
                }
            }
          , '_ro' => sub
            { ($name,$type) = splice(@args,0,2)
            ; push @acc, "_$name", $type
            ; if(lc($args[0]) eq 'abstract')
                { shift @args
                }
              else
                { push @r_, $name => sub
                    { my $idx = _value_of HO::accessor "_$name"
                    ; return HO::accessor::ro($name,$idx,$type)
                    }
                }
            }
          # no actions => options
          , 'noconstructor' => sub
            { shift @args
            , $makeconstr = 0
            }
          , ' alias' => sub
            { 
            }
          , 'breakalias' => sub
            { 
            }
          }->{$action}||sub { die "Unknown action '$action' for $package."
                            })->()
    }
    ; if($makeconstr)
        { local $HO::accessor::class = $class 
        ; import HO::accessor \@acc 
        }

    ; { no strict 'refs'; local $_
      ; while(@methods)
          { my ($name,$code)=splice(@methods,0,2)
          ; my $idx = _value_of HO::accessor "_$name"
          ; *{join('::',$class,$name)} = sub 
               { my $self = shift
               ; $self->[$idx] ? $self->[$idx]->($self,@_)
                               : $code->($self,@_)
               }
          }
      ; while(@lvalue)
          { my $name = shift(@lvalue)
          ; my $idx = _value_of HO::accessor "_$name"
          ; *{join('::',$class,$name)} = sub : lvalue
	           { shift()->[$idx]
	           }
          }
      ; while(my ($name,$subref)=splice(@r_,0,2))
          { *{join('::',$class,$name)} = $subref->()
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


