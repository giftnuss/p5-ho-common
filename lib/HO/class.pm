  package HO::class
# *****************
; our $VERSION=$HO::VERSION
# *************************
; use strict; use warnings

; require HO::accessor
; require Carp

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
            ; my $dach = index $name,'^'
            ; if($dach>0)
                { $name = substr($name,0,$dach)
                ; push @acc, "__$name",sub { $code }
                }
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
                    { my $idx = HO::accessor::_value_of($class,"_$name")
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
                    { my $idx = HO::accessor::_value_of($class,"_$name")
                    ; return HO::accessor::ro($name,$idx,$type)
                    }
                }
            }
          # no actions => options
          # all are unsupported until now
          , 'noconstructor' => sub
            { shift @args
            # $makeconstr = 0
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
        ; import HO::accessor:: \@acc 
        }

    ; { no strict 'refs'
      ; while(@methods)
          { my ($name,$code)=splice(@methods,0,2)
          ; my $dach = index $name,'^'
          ; if($dach > 0)
              { $name = substr($name,0,$dach) 
              ; my $idx = HO::accessor::_value_of($class,"_$name")
              ; my $cdx = HO::accessor::_value_of($class,"__$name")
              ; *{join('::',$class,$name)} = sub 
                  { my $self = shift; return
                    $self->[$idx] ? $self->[$idx]->($self,@_)
                                  : $self->[$cdx]->($self,@_)
                  }
              }
            else
              { my $idx = HO::accessor::_value_of($class,"_$name")
              ; *{join('::',$class,$name)} = sub 
                  { my $self = shift; return
                    $self->[$idx] ? $self->[$idx]->($self,@_)
                                  : $code->($self,@_)
                  }
              }
          }
      ; while(@lvalue)
          { my $name = shift(@lvalue)
          ; my $idx = HO::accessor::_value_of($class,"_$name")
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
  ; $args{'name'} || Carp::croak 'no name'
  ; $args{'in'}   ||= $args{'of'}->[0]
  ; unless($args{'code'})
      { if(ref $args{'codegen'})
	  { 
	    $args{'code'} = $args{'codegen'}->(%args) 
	  }
	else
	  { $args{'code'} = ''
	  }
      }
  # optional shortcut_in
      
  ; my $code = 'package '.$args{'in'}.'::'.$args{'name'}.';'
             . 'our @ISA = qw/'.join(' ',@{$args{'of'}}).'/;' . $args{'code'}
      
  ; if($args{'shortcut_in'})
      { my $sc = $args{'shortcut'} || $args{'name'}
      ; $code .= 'package '.$args{'shortcut_in'}.';'
	       . 'sub '.$sc.' { new '.$args{'in'}.'::'.$args{'name'}.'::(@_) }'
      }
  ; eval $code
  ; Carp::croak($@) if $@
  }

; 1

__END__

=head1 NAME

HO::class - class builder for hierarchical objects

=head1 SYNOPSIS

   package Foo::Bar;
   use HO::class
      _lvalue => hey => '@',
      _method => huh => sub { print 'go' }
      _rw     => spd => '%'
      _ro     => cdu => '$'
      
=head1 DESCRIPTION

This is a class builder. It does work during compile time. 

Until now there are five different keywords which can be used
to define different accessors.

=head2 A Simple Slot To Define

=head2 Methods Changeable For A Object

How you can see, it is quite easy to do this in perl. Here during
class construction you have to provide the default method, which
is used when the object does not has an own method.

The method name can be appended with an additional parameter C<static>
separated by a colon. This means that the default method is stored
in an additional slot in the object. So it is changeable on per class
base. This is not the default, because the extra space required.

   use HO::XML
       _method => namespace:static => sub { undef }
       
Currently the word behind the colon could be free choosen. Only the
existence of a colon in the name is checked.
   
 
