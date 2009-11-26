  package HO::HTML::Style
# ***********************
; our $VERSION='0.01'
# *******************
; use strict; use warnings

; use HO::HTML functional => [qw/Link/]

; sub Stylefile
    { my (%args)= @_
    ; my $file  = $args{'src'} || $args{'href'}
    ; my $media = $args{'media'} || 'screen'
    ; my $link = Link()->rel('stylesheet')->type('text/css')
    ; $link->href($file) if $file
    ; $link->media($media) if $media
    ; return $link
    }

; sub Style
    { HO::HTML::Style(@_)->type('text/css')
    }

; 1

__END__

=head1 NAME

HO::HTML::Style

=head1 SYNOPSIS

    import from 'HO::HTML::Style' => qw/Stylefile Style/;

    Stylefile(src => '/css/core.css'); # media screen is default
    Style(<<__CSS__);
    h1 { font-size: 90pt; }
    __CSS__

=head1 DESCRIPTION

