; use strict; use warnings
; no warnings "void"
; use Test::More tests => 3

; BEGIN
    { use_ok('HO::Tmpl::Markup::CDML','Cdml')
    }

; package CDML::If
; use HO::structure
; use base 'HO::structure'

; __PACKAGE__->make_slots qw(condition if else)

; sub get { "$_[0]" }

; sub new
    { my ($class,$cond,$if)=@_
    ; my $self = $class->HO::structure::new()
    ; my @st  =new HO()->copy(4)
    ; $st[0] << '[FMP-If: '  << $st[1]**$cond << ']' 
                             << $st[2]**$if   << '[/FMP-If]'
    ; $self->set_root($st[0])
    
    ; my @slot=("condition","if")
    
    ; foreach ( 0..$#slot )
        { $self->set_area($slot[$_],$st[$_+1]) }
    ; $self
    }

; package CDML::IfElse
; use base 'CDML::If'

; sub new
    { my ($class,$cond,$if,$else)=@_
    ; my $self = $class->HO::structure::new()
    ; my @st  =new HO()->copy(4)
    ; $st[0] << '[FMP-If: '  << $st[1]**$cond << ']' 
                             << $st[2]**$if
             << '[FMP-Else]' << $st[3]**$else << '[/FMP-If]'
    ; $self->set_root($st[0])
    ; my @slot=qw(condition if else)
    ; foreach ( 0..$#slot )
        { $self->set_area($slot[$_],$st[$_+1]) }
    ; $self
    }
    
; package CDML::Choice
; use base 'CDML::If'

; sub new
    { my ($class,@args)=@_
    ; my $self=$class->SUPER::new()
    ; my $root = new HO()
    ; my ($bc,$bv)=(shift(@args),shift(@args))
    ; $root << '[FMP-If: ' << new HO($bc) << ']' << new HO($bv)
    
    ; my $default= @args % 2 ? pop(@args) : ""
    ; while( @args )
        { $root << '[FMP-ElseIf: ' << new HO(shift(@args)) << ']' 
                                   << new HO(shift(@args)) 
        }
    ; $root << '[FMP-Else]' << new HO($default) << '[/FMP-If]'
    ; $self->set_root($root)
    ; $self
    }
    
; package main

; is(Cdml()->choice("FLD.eq.VAL","true"),new CDML::If("FLD.eq.VAL","true"))


; is( Cdml()->choice("FLD.eq.VAL","true","false")
    , new CDML::IfElse("FLD.eq.VAL","true","false"))
    
    
; "giftnuss"

__END__