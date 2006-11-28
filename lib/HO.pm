
; use strict; use warnings; no warnings "void"

; package HO

; use Carp
;;

=head1 NAME

HO - Hierarchical Objects

=head1 VERSION

Version 0.059

  $Id: HO.pm,v 1.1 2006/11/24 16:41:00 dirk Exp $

=cut

; our $VERSION = 0.059
; require 5.005
;;

=head1 SYNOPSIS

 use HO;
 no warnings 'void';

 my $obj=HO('text',$other_object);
 
 $obj->insert('more text');
 $obj << $another_object ** 'anymore text';
 
 print "$obj";

=head1 DESCRIPTION

C<HO> stands for Hierarchical Objects and plays the role as base class 
and interface for different extended objects. With this object it 
is simple to build up a hierarchy by the way to put one object into 
another and finally create a string from the whole structure. 

This principle is not new and there are similar implementations in the CPAN. 
But this is mine and I hope other programmer found it useful and use it too.

I'm open for any suggestions and each form of constructive criticism. This
modul was build after a long evolutionary process. First time it grows, than
it was split, names becomes shorter and finally it was split into a class hierarchy.

=head2 WARNING

If an object is inserted somewhere inside of hisself an endless
loop will be the result of the string method. In the future another class
maybe C<HO::Safe> will targeting this issue.
   
=cut

; use constant THREAD => 0
;;

=head2 new / HO

The classical constructor C<new> and a subroutine whith class as name 
companion which could be imported in your namespace build a object.
As argument is everthing allowed what can be stringified. Addotional
an arrayref is dereferenced and the content is used as arguments

=cut

; sub new
    { my $class = shift
       ; $class = ref($class) if ref($class)
    ; my $self  = [ [] ]
    ; bless $self, $class
    ; $self->insert( @_ )
    }

; sub HO { new HO ( @_ ) }
;;

=head2 Protected Accessor

  _thread : lvalue - the content

Protected in the sense of c++. Only subclasses should use it.

=cut

; sub _thread : lvalue { $_[0]->[THREAD] }
;;
        
=head1 Public Interface

=head2 insert or << or **

With this method or operators the content is inserted.

=cut

; sub insert
    { my $self = shift
    ; push @{$self->_thread}, map { ref eq 'ARRAY' ? new HO(@$_) : $_ } @_
    ; $self
    }
;;

=head2 splice

Apply CORE::splice on the content array. The arguments are the same as for
splice without first.

=cut

; sub splice
    { my $self = shift
    ; CORE::splice(@{$self->_thread},@_)
    }
;;

=head2 string or "" operator

Make a string from the object.

=cut

; sub string
    { my $self=shift
    ; my $r   = ""
    ; $r .= ref($_) ? "$_" : $_ foreach $self->content
    ; return $r
    }
;;

=head2 content

=cut

; sub content
    { @{$_[0]->_thread} }
;;

=head2 concat or + operator

=cut

; sub concat
    { my ($o1,$o2,$reverse)=@_
    ; ($o2,$o1)=($o1,$o2) if $reverse
    ; new HO($o1,$o2)
    }
;;

=head2 copy

This makes no deep copy. Please use Clonable for this task.
May have a number as argument and makes so many copies of the
original. The return value is an array or in scalar context 
an arrayref.

=cut

; sub copy
    { my ($obj,$arg)=@_
    ; my $num = defined($arg) && ($arg > 1) ? $arg : 1
    ; my @copy
    ; for ( 1..$num )
        { my $copy=$obj->new()
        ; @{$copy->_thread} = @{$obj->_thread()}
        ; push @copy,$copy
        }
    ; wantarray ? @copy : defined($arg) ? \@copy : $copy[0] 
    }
;;

=head2 multiply or * operator

=cut

; sub multiply
    { my ($o,$num)=@_
    ; return new HO($o->copy($num))
    }
;;
  
=head1 NOTES

=head2 operator <<

	$obj << $other_obj; # or
	$obj << \@array;    # because a plain Array doesn't work with operator

This makes the code more like c++. Funny Thing, which works fine. Only the warning
is bad, which is produced because the void context. This is could be disabled with:
  
  no warnings 'void'

and you have to do this for each file where this operator is used.

=head2 operator bool

An object in boolean context is always true.

=cut

; use overload
    '<<'     => "insert",
    '**'     => "insert",
    '""'     => "string",
    '+'      => "concat",
    '*'      => "multiply",
    'bool'   => sub{ 1 },
    fallback => 1,
    nomethod => sub { croak "illegal operator $_[3] in ".join(" ",caller(2) ) }

  
; 1

__END__



=head1 AUTHOR

	Sebastian Knapp
	CPAN ID: SKNPP
	Computer-Leipzig.com
	sk@computer-leipzig.com

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

This is somthing to do.

=cut

