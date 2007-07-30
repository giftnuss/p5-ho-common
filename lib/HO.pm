  package HO
# ==========
; use strict; our $VERSION='0.06';
# ================================

=head1 NAME

HO - Hierarchical Objects

=head1 VERSION

Version 0.06

  $Id: HO.pm,v 1.1 2006/11/24 16:41:00 dirk Exp $

=cut

# TODO: needs testing
; require 5.006
;;

=head1 SYNOPSIS

   use HO;
   no warnings 'void';

   my $obj=new HO('text',$other_object);
 
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
it was split, names becomes shorter and finally it was splited into a class 
hierarchy. Last feature was the dynamic constructor to solve the problem 
when different sublasses uses the same index for an object property.  

Some mothods are changeable on an object. This function is provided by the 
HO::class package.

=head2 WARNING

If an object is inserted somewhere inside of hisself an endless
loop will be the result of the string method. In the future another class
maybe C<HO::Safe> will targeting this issue.

=head2 new and init

The constructor C<new> is created by the L<HO::accessor> module. 
This constructor calls the init method. so you have to overwrite
this in your subclasses and never the constructor. If you do so, almost
all other methods must be overwritten too.

As argument is everthing allowed what can be stringified. Additional
an arrayref in the arguments list is dereferenced and the content is 
used as arguments too.

=head2 insert or << or **

With this method or operators the content is inserted.

=cut

; use subs qw/init/

; use HO::class

    accessor => __thread => '@',

    method   => insert   => sub
       { my $self = shift
       ; push @{$self->_thread}, map { ref eq 'ARRAY' ? new HO(@$_) : $_ } @_
       ; $self
       }

; sub init
    { shift->insert( @_ ) }
;

=head2 Protected Accessor

  _thread : lvalue - the content

Protected in the sense of c++. Only subclasses should use it.

=cut

; sub _thread : lvalue { $_[0]->[&__thread] } ;

=head1 Public Interface

=head2 replace

=cut

; sub replace
    { my $self = shift
    ; @{$self->_thread}=()
    ; $self->insert(@_)
    }


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

=head2 copy or * operator

This makes no deep copy. Please use Clonable for this task.
May have a number as argument and makes so many copies of the
original. The return value is an array or in scalar context 
an arrayref.

=cut

; sub copy
    { my ($obj,$arg,$reverse)=@_
    ; ($obj,$arg)=($arg,$obj) if $reverse
    ; my $num = defined($arg) && ($arg > 1) ? int($arg) : 1
    ; my @copy
    ; for ( 1..$num )
        { my $copy=$obj->new()
        ; @{$copy->_thread} = @{$obj->_thread()}
        ; push @copy,$copy
        }
    ; wantarray ? @copy : defined($arg) ? \@copy : $copy[0] 
    }
;

=head2 count

Simply returns the number of child elements in the first level.

=cut

; sub count
   { scalar @{$_[0]->_thread} }

=head1 NOTES

=head2 operator <<

	$obj << $other_obj; # or
	$obj << \@array;    # because a plain Array doesn't work with operator

This makes the code more like c++. Funny thing, which works fine. Only the warning
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
    '*'      => "copy",
    'bool'   => sub{ 1 },
    fallback => 1,
    nomethod => sub { die "illegal operator $_[3] in ".join(" ",caller(2) ) }
  
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

This is something to do.

=cut

