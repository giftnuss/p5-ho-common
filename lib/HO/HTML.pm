  package HO::HTML
# ****************
; our $VERSION='0.01'
# *******************

; use strict; use warnings; use utf8
; use Carp ()

; require Exporter
; our @ISA = ('Exporter')
; our (@EXPORT_OK,@EXPORT)

; use Package::Subroutine ()
; use HO::ClassBuilder ()

; use HO::HTML::Element ()
; use HO::HTML::Element::Heading ()

; use Data::Dumper

# L = loaded
# Function = Name der Standardfunktion im HO::HTML Namensraum
# A = Basisklasse (index)
# T = is_single_tag
# H = nur im Header
# B = Block Element
# I = Inline Element
# S = in strict erlaubt
# D = nur daten erlaubt

; our @elements = #   L, Function,     A, T, S, B
    ( 'a'        => [ 0, 'A',          0, 0, 1, 0, ]
    , 'abbr'     => [ 0, 'Abbr',       0, 0, 1, 0, ]
    , 'acronym'  => [ 0, 'Acronym',    0, 0, 1, 0, ]
    , 'address'  => [ 0, 'Address',    0, 0, 1, 1, ]
    , 'applet'   => [ 0, 'Applet',     0, 0, 0, 0, ]
    , 'area'     => [ 0, 'Area',       0, 1, 1, 0, ]
    , 'b'        => [ 0, 'Bold',       0, 0, 1, 0, ]
    , 'base'     => [ 0, 'Base',       0, 1, 1, 0, ]
    , 'basefont' => [ 0, 'Basefont',   0, 1, 0, 0, ]
    , 'bdo'      => [ 0, 'Bdo',        0, 0, 1, 0, ]
    , 'big'      => [ 0, 'Big',        0, 0, 1, 0, ]
    , 'blockquote', [ 0, 'Blockquote', 0, 0, 1, 1, ]
    , 'body'     => [ 0, 'Body',       0, 0, 1, 0, ]
    , 'br'       => [ 0, 'Br',         0, 1, 1, 0, ]
    , 'button'   => [ 0, 'Button',     0, 1, 1, 0, ]
    , 'caption'  => [ 0, 'Caption',    0, 0, 1, 0, ]
    , 'center'   => [ 0, 'Center',     0, 0, 0, 1, ]
    , 'cite'     => [ 0, 'Cite',       0, 0, 1, 0, ]
    , 'code'     => [ 0, 'Code',       0, 0, 1, 0, ]
    , 'col'      => [ 0, 'Col',        0, 0, 1, 0, ]
    , 'colgroup' => [ 0, 'Colgroup',   0, 0, 1, 0, ]
    , 'dd'       => [ 0, 'Dd',         0, 0, 1, 0, ]
    , 'del'      => [ 0, 'Del',        0, 0, 1, 1, ]
    , 'dfn'      => [ 0, 'Dfn',        0, 0, 1, 0, ]
    , 'dir'      => [ 0, 'Dir',        0, 0, 0, 1, ]
    , 'div'      => [ 0, 'Div',        0, 0, 1, 1, ]
    , 'dl'       => [ 0, 'Dl',         0, 0, 1, 1, ]
    , 'dt'       => [ 0, 'Dt',         0, 0, 1, 0, ]
    , 'em'       => [ 0, 'Em',         0, 0, 1, 0, ]
    , 'fieldset' => [ 0, 'Fieldset',   0, 0, 1, 1, ]
    , 'font'     => [ 0, 'Font',       0, 0, 0, 0, ]
    , 'form'     => [ 0, 'Form',       0, 0, 1, 1, ]
    , 'frame'    => [ 0, 'Frame',      0, 1, 0, 0, ]
    , 'frameset' => [ 0, 'Frameset',   0, 0, 0, 0, ]
    , 'h1'       => [ 0, 'H1',         1, 0, 1, 1, ]
    , 'h2'       => [ 0, 'H2',         1, 0, 1, 1, ]
    , 'h3'       => [ 0, 'H3',         1, 0, 1, 1, ]
    , 'h4'       => [ 0, 'H4',         1, 0, 1, 1, ]
    , 'h5'       => [ 0, 'H5',         1, 0, 1, 1, ]
    , 'h6'       => [ 0, 'H6',         1, 0, 1, 1, ]
    , 'head'     => [ 0, 'Head',       0, 0, 1, 0, ]
    , 'hr'       => [ 0, 'Hr',         0, 1, 1, 1, ]
    , 'html'     => [ 0, 'Html',       0, 0, 1, 0, ]
    , 'i'        => [ 0, 'Italic',     0, 0, 1, 0, ]
    , 'iframe'   => [ 0, 'IFrame',     0, 0, 0, 0, ]
    , 'img'      => [ 0, 'Img',        0, 1, 1, 0, ]
    , 'input'    => [ 0, 'Input',      0, 1, 1, 0, ]
    , 'ins'      => [ 0, 'Ins',        0, 0, 1, 1, ]
    , 'isindex'  => [ 0, 'IsIndex',    0, 0, 0, 1, ]
    , 'kbd'      => [ 0, 'Kbd',        0, 0, 1, 0, ]
    , 'label'    => [ 0, 'Label',      0, 0, 1, 0, ]
    , 'legend'   => [ 0, 'Legend',     0, 0, 1, 0, ]
    , 'li'       => [ 0, 'Li',         0, 0, 1, 0, ]
    , 'link'     => [ 0, 'Link',       0, 1, 1, 0, ]
    , 'map'      => [ 0, 'Map',        0, 0, 1, 0, ]
    , 'menu'     => [ 0, 'Menu',       0, 0, 0, 1, ]
    , 'meta'     => [ 0, 'Meta',       0, 1, 1, 0, ]
    , 'noframes' => [ 0, 'NoFrames',   0, 0, 0, 1, ]
    , 'noscript' => [ 0, 'NoScript',   0, 0, 1, 1, ]
    , 'object'   => [ 0, 'Object',     0, 0, 1, 0, ]
    , 'ol'       => [ 0, 'Ol',         0, 0, 1, 1, ]
    , 'optgroup' => [ 0, 'Optgroup',   0, 0, 1, 0, ]
    , 'option'   => [ 0, 'Option',     0, 0, 1, 0, ]
    , 'p'        => [ 0, 'P',          0, 0, 1, 1, ]
    , 'param'    => [ 0, 'Param',      0, 1, 1, 0, ]
    , 'pre'      => [ 0, 'Pre',        0, 0, 1, 1, ]
    , 'q'        => [ 0, 'Q',          0, 0, 1, 0, ]
    , 's'        => [ 0, 'S',          0, 0, 0, 0, ]
    , 'samp'     => [ 0, 'Sample',     0, 0, 1, 0, ]
    , 'script'   => [ 0, 'Script',     0, 0, 1, 0, ]
    , 'select'   => [ 0, 'Select',     0, 0, 1, 0, ]
    , 'small'    => [ 0, 'Small',      0, 0, 1, 0, ]
    , 'span'     => [ 0, 'Span',       0, 0, 1, 0, ]
    , 'strike'   => [ 0, 'Strike',     0, 0, 0, 0, ]
    , 'strong'   => [ 0, 'Strong',     0, 0, 1, 0, ]
    , 'style'    => [ 0, 'Style',      0, 0, 1, 0, ]
    , 'sub'      => [ 0, 'Sub',        0, 0, 1, 0, ]
    , 'sup'      => [ 0, 'Sup',        0, 0, 1, 0, ]
    , 'table'    => [ 0, 'Table',      0, 0, 1, 1, ]
    , 'tbody'    => [ 0, 'TBody',      0, 0, 1, 0, ]
    , 'td'       => [ 0, 'Td',         0, 0, 1, 0, ]
    , 'textarea' => [ 0, 'Textarea',   0, 0, 1, 0, ]
    , 'tfoot'    => [ 0, 'TFoot',      0, 0, 1, 0, ]
    , 'th'       => [ 0, 'Th',         0, 0, 1, 0, ]
    , 'thead'    => [ 0, 'THead',      0, 0, 1, 0, ]
    , 'title'    => [ 0, 'Title',      0, 0, 1, 0, ]
    , 'tr'       => [ 0, 'Tr',         0, 0, 1, 0, ]
    , 'tt'       => [ 0, 'Tt',         0, 0, 1, 0, ]
    , 'u'        => [ 0, 'U',          0, 0, 0, 0, ]
    , 'ul'       => [ 0, 'Ul',         0, 0, 1, 1, ]
    , 'var'      => [ 0, 'Var',        0, 0, 1, 0, ]
    )

; our @baseclasses =
    ( 'HO::HTML::Element'
    , 'HO::HTML::Element::Heading'
    )

; sub seq_props
    { map { ($_*=2)-1 } 1..($#elements+1)/2
    }

; sub list_names
    { map { $elements[$_*2] } 0..($#elements-1)/2
    }

; sub list_loaded
    { map { $elements[$_*2] }
      grep { $elements[$_*2+1]->[0] } 0..($#elements-1)/2
    }

############################
# IMPORT
# tags => arrayref with tags to build
# functional => true or arrayref - export tags as functions
############################

; sub import
  { my ($pkg,@args)=@_
  ; our @elements
  ; local $_

  # create only a subset of tags
  ; for (0,2)
      { if(defined($args[$_]) && $args[$_] eq 'tags')
          { my (undef,$tags) = splice(@args,$_,2)
          ; $pkg->create_tags(@{$tags})
          }
      }

  # otherwise build all tags
  ; unless(grep { $elements[$_]->[0] } seq_props())
      { $pkg->create_tags($pkg->list_names)
      }

  ; { local @EXPORT
    ; if(@args && $args[0] eq 'functional')
      { #local @EXPORT
      ; if(ref $args[1] eq 'ARRAY')
          { @EXPORT = @{$args[1]}
          }
        else
          { for(my $i=1; $i<=$#elements; $i+=2)
              { push @EXPORT, $elements[$i]->[1]
                  if $elements[$i]->[0]
              }
          }
      ; $pkg->export_to_level(1,$pkg,@EXPORT)
      }
    }
  }

; sub create_tags
    { my ($pkg,@tags) = @_
    ; our @elements
    ; TAGS:
      foreach my $tag (@tags)
        { for(my $i=0; $i<$#elements; $i+=2)
            { if($tag eq $elements[$i])
                { unless($elements[$i+1]->[0])
                    { $pkg->create_a_tag($i)
                    ; $elements[$i+1]->[0] = 1
                    }
                ; next TAGS
                }
            }
        }
    }

; my $default_init

; sub create_a_tag
    { my ($pkg,$idx) = @_
    ; our (@elements,@baseclasses,@inits)
    ; my $p = $idx+1

    ; my $builder = HO::ClassBuilder->new
        ( name => ucfirst($elements[$idx])
        , namespace => ['HO','HTML','Element']
        , version => $VERSION
        , parents => [ $baseclasses[ $elements[$p]->[2] ] ]
        , methods =>
            { init => $inits[$elements[$p]->[2]]->( $elements[$p]->[3], $elements[$idx])
            }
        )
    ; $builder->build
    ; $builder->make_shortcut(__PACKAGE__, $elements[$p]->[1])
    ; 1
    }

; our @inits =
    ( # default init
      sub
        { my ($single,$name) = @_
        ; return sub
          { my ($self,@args) = @_
          ; $self->_is_single_tag = $single
          ; $self->insert($name,@args)
          ; $self
          }
        }
    , # heading init
      sub
        { my ($single,$name) = @_
        ; return sub
          { my ($self,@args) = @_
          ; $self->_is_single_tag = $single
          ; $self->insert($name, @args)
          ; my $level = $self->default_level
          ; $self->level($level)
          ; $self
          }
        }
    )

#############################
# Special Functions
#############################
# needs many fixes for more header elements
; sub H
    { my ($level,@args) = @_
    ; (($level ||= 1) && $level>0 && $level<7) or
        do { unshift @args, $level; $level=1 }
    ; if(my $header = HO::HTML->can('H'.$level))
        { return &$header(@args)
        }
    ; Carp::croak "Header element class 'h$level' not initialized."
    }

#############################
# Factory
#############################
; sub factory
    { my $tagname = shift
    ; return html_element($tagname)->(@_)
    }

; sub html_element
    { my ($tagname) = @_
    ; our @elements
    ; my %elements = @elements

    ; my $def = $elements{lc($tagname)}
        or Carp::croak("Unknown tag '$tagname'.")

    ; my $func = HO::HTML->can($def->[1])
        or Carp::croak("Undefined function HO::HTML::" . $def->[1]. ".")

    ; return $func
    }

; use Memoize
; memoize('html_element')
; no Memoize

; 1

__END__

=head1 NAME

HO::HTML

=head1 BUGS

   * import functional for subclasses does not work
