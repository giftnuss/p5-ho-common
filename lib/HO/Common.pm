  package HO::Common
# ******************
; our $VERSION='0.02'
# *******************

; use strict

; require Exporter
; our @ISA = ('Exporter')

; our @EXPORT = ()
; our @EXPORT_OK = qw/node newline/

; use HO::Node ()

; sub node { new HO::Node::(@_) }

; sub newline
    { return new HO::Object::("\n") unless @_
    ; return new HO::Object::("\n",@_,"\n")
    }

; 1

__END__

=head1 NAME

HO::common

=head1 SYNOPSIS

  use HO::Common qw/node newline/;

  my $n = node() << newline();

=head1 DESCRIPTION

This module contains some functions which are useful when you work
with hierarchical object (HO) modules.

=head2 node()

This is an alias to say C<new HO::node::()>. The sense why to this in favour
of the direct constructor call is that a fuction is easier replaced during
runtime and it is a little bit less to type.

=head2 newline()

This is only a function to say C<"\n">.

=head1 AUTHOR

Sebastian Knapp E<lt>sk@computer-leipzig.comE<gt>

=head1 COPYRIGHT & LICENSE

Copyright 2007-2008 Sebastian Knapp, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
