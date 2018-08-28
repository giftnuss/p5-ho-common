  package HO::HTML::Document
# **************************
; our $VERSION = '0.03'
# *********************
; use strict; use warnings; use utf8
; no warnings 'void'

; use base 'HO::structure'

; use HO::Common qw/node newline/
; use HO::HTML

; __PACKAGE__->make_slots( qw(head title body meta style script) )

; sub new
    { my ($class)=shift
    ; my %p=@_
    ; my $doctype   = _doctype($p{'doctype'} || 'transitional')
    ; my $titletext = $p{'title'} || ''
    ; my $metatags  = $p{'metatags'} || []
    ; my $root      = node()

    ; my %slot=
        ( head   => HO::HTML::Head()
        , title  => HO::HTML::Title($titletext)
        , body   => HO::HTML::Body()
        , meta   => node($metatags)
        , style  => node()
        , script => node()
        )

    ; my ($html)=(HO::HTML::Html())
    ; $root << $doctype << newline()
            << ($html << newline()
                      << ($slot{head} << $slot{meta}
                                      << $slot{title}
                                      << $slot{style}
                                      << $slot{script})
                      << $slot{body}) << newline()

    ; my $self=$class->SUPER::new()

    ; $self->set_root($root)
    ; while( my ($slot,$area)=each(%slot) )
        { $self->set_area($slot,$area) }

    ; $self
    }

; our %DOCTYPE =
    ( html2 =>
    '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">'
    , transitional =>
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">'
    , strict =>
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
            "http://www.w3.org/TR/html4/strict.dtd">'
    , frameset =>
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">'
    , html5 =>
    '<!doctype html>'
    , none => ''
    )

; sub _doctype
    { shift if $_[0] eq __PACKAGE__
    ; return
        $DOCTYPE{$_[0]} || ''
    }

; sub NoCache
    { my ($self)=shift
    ; $self->meta('<meta http-equiv="pragma" content="no-cache">',"\n"
                 ,'<meta http-equiv="expires" content="0">',"\n");
    ; $self
    }

; sub EnCoding
    { my $self=shift
    ; my $enc =shift || "UTF-8"
    ; $self->meta(
        "<meta http-equiv=\"content-type\" content=\"text/html; charset=${enc}\">\n"
    )
    ; $self
    }

; 1

__END__

