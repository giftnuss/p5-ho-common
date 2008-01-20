  package HO::accessor
# ++++++++++++++++++++
; our $VERSION='0.01'
# +++++++++++++++++++
; use strict; use warnings

; use Class::ISA

; my %classes
; my %accessors

; our %type = ('@'=>sub{[]},'%'=>sub{{}},'$'=>sub{undef})

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
                     ; $obj->[$i]->{$key}
                 }}
    )
    
; our %rw_accessor =
    ( '$' => sub { my ($n,$i) = @_
                 ; return sub { my ($obj,$val) = @_
                     ; return $obj->[$i] unless defined $val
                     ; $obj->[$i] = $val
                     ; return $obj
                 }}
    )

; our $class

; sub import
    { my ($package,$ac) = (@_,[])
    ; my $caller = $HO::accessor::class || caller

    ; die "HO::accessor::import already called for class $caller."
        if $classes{$caller}

    ; $classes{$caller}=$ac

    ; my @build = reverse Class::ISA::self_and_super_path($caller)
    ; my @constructor

    ; my $count=0
    ; foreach my $class (@build)
        { my @acc=@{$classes{$class}} or next
        ; while (@acc)
            { my ($accessor,$type)=splice(@acc,0,2)
            ; my $proto=$type{$type}
            ; unless(ref $proto eq 'CODE')
                { warn "Unknown property type '$type', in setup for class $caller."
                ; $proto=sub{undef}
                }
            ; if($accessors{$class}{$accessor})
                { $constructor[$accessors{$class}{$accessor}->()]=$type{$type}
                }
              else
                { my $val=$count
                ; my $acc=sub {$val}
                ; $accessors{$class}{$accessor}=$acc
                ; $constructor[$acc->()]=$type{$type}
                }
            ; $count++
            }
        }
    ; { no strict 'refs'
      ; *{"${caller}::new"}=
          $caller->can('init') ?
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
    }

# Package Method
; sub accessors_for_class
    { my ($self,$class)=@_
    ; $classes{$class}
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






