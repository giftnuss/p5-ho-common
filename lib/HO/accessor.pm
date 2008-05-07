  package HO::accessor
# ++++++++++++++++++++
; our $VERSION='0.01'
# +++++++++++++++++++
; use strict; use warnings

; use Class::ISA

; my %classes
; my %accessors

; our %type = ('@'=>sub{[]},'%'=>sub{{}},'$'=>sub{undef})

; our %init =
    ( 'hash' => sub
        { my ($self,%args) = @_
        ; while(my ($method,$value)=each(%args))
            { my $access = "_$method" 
            ; $self->[$self->$access] = $value            	
            }
        ; return $self
        }
    )

; our %ro_accessor =
    ( '$' => sub { my ($n,$i) = @_ 
                 ; return sub (){ shift()->[$i] } 
                 }
    , '@' => sub { my ($n,$i) = @_
                 ; return sub { my ($obj,$idx) = @_
                     ; $obj->[$i]->[$idx]
                 }}
    , '%' => sub { my ($n,$i) = @_
                 ; return sub { my ($obj,$key) = @_
                 ; (@_==1) ? {%{$obj->[$i]}}
                           : $obj->[$i]->{$key}
                 }}
    )
    
; our %rw_accessor =
    ( '$' => sub { my ($n,$i) = @_
                 ; return sub { my ($obj,$val) = @_
                     ; return $obj->[$i] unless defined $val
                     ; $obj->[$i] = $val
                     ; return $obj
                 }}
    , '@' => sub { my ($n,$i) = @_
                 ; return sub { my ($obj,$idx,$val) = @_
                     ; if(@_==1) # get values
                         { # etwas mehr Zugriffsschutz da keine Ref
                           # einfache Anwendung in bool Kontext
                         ; return @{$obj->[$i]}
                         }
                     ; if(ref $idx eq 'ARRAY')
                         { $obj->[$i] = $idx                 # set complete array
                         ; return $obj
                         }
                       else
                         { if(@_==3)                         
                             { if($idx eq '<')
                                 { push @{$obj->[$i]}, $val
                                 }
                               elsif($idx eq '>')
                                 { unshift @{$obj->[$i]}, $val
                                 }
                               else
                                 { $obj->[$i]->[$idx] = $val     # set one index
                                 }
                             ; return $obj
                             }
                           else
                             { return $obj->[$i]->[$idx]     # get one index
                             }
                         }
                 }}
    , '%' => sub { my ($n,$i) = @_
                 ; return sub { my ($obj,$key) = @_
                 ; if(@_==1)
                     { return $obj->[$i] # for a hash an reference is easier to handle
                     }
                   elsif(@_==2)
                     { if(ref($key) eq 'HASH')
                     	{ $obj->[$i] = $key
                     	; return $obj
                     	}
                       else
                        { return $obj->[$i]->{$key}
                        }
                     }
                   else
                     { shift(@_)
                     ; my @kv = @_
                     ; while(@kv)
                         {
                         	$obj->[$i]->{shift(@kv)} = shift(@kv)
                         }
                     ; return $obj
                     }
                 }}
    )

; our $class

; sub import
    { my ($package,$ac,$init) = @_
    ; $ac   ||= []

    ; my $caller = $HO::accessor::class || caller

    ; die "HO::accessor::import already called for class $caller."
        if $classes{$caller}

    ; $classes{$caller}=$ac

    ; my @build = reverse Class::ISA::self_and_super_path($caller)
    ; my @constructor

    ; my $count=0
    ; foreach my $class (@build)
        { $classes{$class} or next
	; my @acc=@{$classes{$class}} or next
        ; while (@acc)
            { my ($accessor,$type)=splice(@acc,0,2)
            ; my $proto = ref($type) eq 'CODE' ? $type : $type{$type}
            ; unless(ref $proto eq 'CODE')
                { warn "Unknown property type '$type', in setup for class $caller."
                ; $proto=sub{undef}
                }
            ; if($accessors{$class}{$accessor})
                { $constructor[$accessors{$class}{$accessor}->()] = $proto
                }
              else
                { my $val=$count
                ; my $acc=sub {$val}
                ; $accessors{$class}{$accessor}=$acc
                ; $constructor[$acc->()] = $proto
                }
            ; $count++
            }
        }
    ; { no strict 'refs'
      ; *{"${caller}::new"}=
          ($init || $caller->can('init')) ?
            sub
              { my ($self,@args)=@_
              ; bless([map {ref() ? $_->() : $_} @constructor], ref $self || $self)
                  ->init(@args)
              }
          : sub
              { my ($self,@args)=@_
              ; bless([map {ref() ? $_->() : $_} @constructor], ref $self || $self)
              }
      ; my %acc=@{$classes{$caller}}
      ; foreach my $acc (keys %acc)
          { *{"${caller}::${acc}"}=$accessors{$caller}{$acc}
          }
      }
      
    # setup init method
    ; if($init)
        { unless(ref($init) eq 'CODE' )
        	{ $init = $init{$init}
        	; unless(defined $init)
        	    { Carp::croak "There is no init defined for init argument $init."
        	    }
        	}
        ; no strict 'refs'
        ; *{"${caller}::init"}= $init
        }
    }

# Package Method
; sub accessors_for_class
    { my ($self,$class)=@_
    ; return $classes{$class}
    }

# Package Function
; sub _value_of
    { my ($class,$accessorname) = @_
    ; my @classes = Class::ISA::self_and_super_path($class)
    ; foreach my $c (@classes)
        { if(defined($accessors{$c}{$accessorname}))
            { #warn $accessorname.": ".$accessors{$c}{$accessorname}->()
            ; return $accessors{$c}{$accessorname}->()
            }
        }
    ; die "Accessor $accessorname is unknown for class $class."
    }

#########################
# this functions defines
# accessors
#########################
; sub ro
    { my ($name,$idx,$type) = @_
    ; return $ro_accessor{$type}->($name,$idx)
    }
    
; sub rw
    { my ($name,$idx,$type) = @_
    ; return $rw_accessor{$type}->($name,$idx)
    }

; 1

__END__

=head1 NAME

HO::accessor
  
=head1 SYNOPSIS

    package HO::World::Consumer;
    use base 'HO::World::Owner';

    use HO::accessor [ industry => '@', profit => '$' ];

=head1 DESCRIPTION

deprecated

=head1 SEE ALSO

L<Class::ArrayObjects> by Robin Berjon (RBERJON)

L<Class::BuildMethods> by Ovid -- add inside out data stores to a class.






