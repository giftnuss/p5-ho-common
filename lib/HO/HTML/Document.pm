  package HO::HTML::Document
# **************************
; our $VERSION = '0.03'
# *********************
; use strict; use warnings; use utf8
; no warnings 'void'

; use base 'HO::structure'

; use HO::common qw/node newline/
; use HO::HTML

#; use HO::HTML::Document::Type

; __PACKAGE__->make_slots qw(head title body meta style script)

; sub new
    { my ($class)=shift
    ; my %p=@_;
    ; my $doctype   = $p{'doctype'} || 'transitional'
    ; my $titletext = $p{'title'} || ''
    ; my $metatags  = $p{'metatags'} || []
    ; my $root      = node() # new HO::HTML::Document::Type
    ; my $head      = HO::HTML::Head()
    ; my %slot=
        ( head   => $head
        , title  => HO::HTML::Title($titletext)
        , body   => HO::HTML::Body()
        , meta   => node($metatags)
        , style  => node()
        , script => node()
        )

    ; my ($html)=(HO::HTML::Html())
    ; $root << newline()
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

; sub NoCache
    { my ($self)=shift
    ; $self->meta('<meta http-equiv="pragma" content="no-cache">',"\n"
                 ,'<meta http-equiv="expires" content="0">',"\n");
    ; $self
    }

; sub EnCoding
    { my $self=shift
    ; my $enc =shift || "ISO-8859-1"
    ; $self->meta(
        "<meta http-equiv=\"content-type\" content=\"text/html; charset=${enc}\">\n"
    )
    ; $self
    }

; 1

__END__
