; package HO::print

; our $VERSION='0.02'

; use HO

; package HO

; use Carp
; use File::Path
; use File::Basename

; sub print
    { print "$_[0]" }

; sub print_into
    { my ($obj,$file)=@_
    ; $dir=dirname($file);
    ; mkpath $dir if not -d $dir
    ; eval
        { open TARGET,">$file" or die "$^E"
        ; my $old=select TARGET
        ; $obj->print
        ; close TARGET or die "$^E"
        ; select $old;
        }
    ; carp "Something is wrong with print_into file $file!\n$@" if $@;
    }

; 1

__END__

=head1 NAME

HO::print - Output methods for Hierarchical Objects
  
=head1 SYNOPSIS

This Module adds two output methods to the HO class.

  use HO::print

  # build up a HO structure

  $obj->print; # sends output to STDOUT

  $obj->print_into('file.html'); # or a file

=cut
