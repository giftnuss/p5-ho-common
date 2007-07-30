  package HO::accessor
# ++++++++++++++++++++
; our $VERSION='0.01'
# +++++++++++++++++++
; use strict; use warnings
  
; use Class::ISA
  
; my %classes
; my %accessors
  
; our %type = ('@'=>sub{[]},'%'=>sub{{}},'$'=>sub{undef})

; our $class

; sub import
    { my ($package,$ac) = (@_,[])
    ; my $caller = $HO::accessor::class || caller
   
    ; die "HO::accessor::import already called for class $caller."
        if $classes{$caller}

    ; $classes{$caller}=$ac
  
    ; my @build = reverse Class::ISA::self_and_super_path($caller)
    ; my @constructor  

    ; foreach my $class (@build)
        { my @acc=@{$classes{$class}} or next
	; while (@acc)
	    { my ($accessor,$type)=splice(@acc,0,2)
	    ; my $proto=$type{$type}
	    ; unless(ref $proto eq 'CODE')
		{ warn "Unknown property type '$type', in setup for class $caller."
		; $proto=sub{undef}
		}
	    ; if($accessors{$accessor})
	        { $constructor[$accessors{$accessor}->()]=$type{$type}
		}
	      else
		{ my $val=scalar keys %accessors
		; my $acc=sub {$val}
		; $accessors{$accessor}=$acc
		; $constructor[$acc->()]=$type{$type}
		}
	    }
	}
    ; { no strict 'refs'
      ; *{"${caller}::new"}=
          $caller->can('init') ?
            sub
	      { my ($self,@args)=@_
	      ; bless([map {ref $_ ? $_->() : $_} @constructor], ref $self || $self)
	          ->init(@args)
	      }
          : sub
              { my ($self,@args)=@_
              ; bless([map {ref $_ ? $_->() : $_} @constructor], ref $self || $self)
              }
      ; my %acc=@{$classes{$caller}}
      ; foreach (keys %acc)
          { *{"${caller}::${_}"}=$accessors{$_}
	  }
      }
    }

; sub accessors_for_class
    { my ($self,$class)=@_
    ; $classes{$class}
    }

; sub _value_of
    { my ($self,$an)=@_
    ; $accessors{$an}->()
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






