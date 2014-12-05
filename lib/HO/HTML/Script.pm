  package HO::HTML::Script
# ************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings; no warnings "void"

; use HO::common qw/node newline/
; use HO::HTML functional => [qw/Script/]

; our @ISA = 'HO::HTML'
; our @EXPORT
; our @EXPORT_OK = qw/Javascript JavascriptNC/
; our %EXPORT_TAGS = (all => \@EXPORT_OK)

# defines a script block
; sub Javascript
    { my (@args) = @_
    ; my $opts = { type => "text/javascript" }
    ; if(ref $args[0] eq 'HASH')
        { $opts =  {%$opts, %{shift @args}}
        }
    ; my $tag = Script()
    ; $tag->type($opts->{'type'}) if $opts->{'type'}

    ; unless($opts->{'nocomment'})
        { my $node = node(@args)
        ; $tag << "<!--//" << newline() << $node << newline() << "//-->" 
        ; $tag->insertpoint($node)
        }
      else
        { $tag << node(@args)
        }

    ; return $tag
    }

; sub JavascriptNC
    { my (@args) = @_
    ; my $opts = {}
    ; $opts = shift @args if ref $args[0] eq 'HASH'
    ; $opts->{'nocomment'} = 1
    ; unshift @args, $opts
    ; return Javascript(@args)
    }

; 1

__END__

