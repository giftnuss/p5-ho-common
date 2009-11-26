  package HO::Tmpl::Markup::TT
# *****************************
; our $VERSION = '0.02'
# *********************
; use strict; use warnings; use utf8

; use parent 'Exporter'
; our @EXPORT_OK = qw/tt/

; use HO::common qw/node/
; use HO::class

; sub AUTOLOAD
    { our $AUTOLOAD
    ; warn $AUTOLOAD
    }

; sub DESTROY {}

; sub tt
    { return 'HO::Tmpl::Markup::TT'
    }

; sub get
    { my ($self,$fieldname,$argsstr) = @_
    ; return HO::Tmpl::Markup::TT::element::GET->new($fieldname,$argsstr)
    }

; sub call
    { my ($self,$call,$argsstr) = @_
    ; return HO::Tmpl::Markup::TT::element::CALL->new($call,$argsstr)
    }

; sub set
    { shift
    ; return HO::Tmpl::Markup::TT::element::SET->new(@_)
    }

; sub setq
    { my ($self,@args) = @_
    ; $args[$_] = "'$args[$_]'" foreach 1 .. $#args
    ; return HO::Tmpl::Markup::TT::element::SET->new(@args)
    }




; package HO::Tmpl::Markup::TT::element
# *************************************
; our $VERSION='0.01'
# *******************
; use base 'HO::tag'

; sub _begin_tag    () { '[% ' }
; sub _close_tag    () { ' %]' }
; sub _close_stag   () { ' %]' }
; sub _begin_endtag () { '[% ' }

; sub set_tag_param
    { my ($self,$param) = @_
    ; return $self->set_attribute('param' => $param)
    }

; sub attributes_string
    { my ($self) = @_
    ; my $param  = $self->get_attribute('param')
    ; return $param ? ": $param" : '' 
    }

; sub AUTOLOAD
    { our $AUTOLOAD
    ; warn "element: " . $AUTOLOAD
    }

; sub DESTROY {}

; package HO::Tmpl::Markup::TT::element::single
# *********************************************
; our $VERSION = '0.01'
# **********************
; use base 'HO::Tmpl::Markup::TT::element'

; sub is_single_tag () { 1 }

; package HO::Tmpl::Markup::TT::element::double
# *********************************************
; our $VERSION = '0.01'
# *********************
; use base 'HO::Tmpl::Markup::TT::element'

; sub is_single_tag () { 0 }

; package HO::Tmpl::Markup::TT::element::DATA
# ********************************************
; our $VERSION = '0.01'
# *********************
; use base 'HO::Tmpl::Markup::TT::element::single'
; use HO::class
    _rw => argstr => '$'

; sub init
    { my ($self,$var,$argstr) = @_
    ; $self->SUPER::init($var)
    ; $self->argstr($argstr) if $argstr
    ; return $self
    }

; sub attributes_string
    { my $self = shift
    ; defined($self->argstr) ? '(' . $self->argstr . ')' : ''
    }

; package HO::Tmpl::Markup::TT::element::GET
# *******************************************
; our $VERSION = '0.01'
# **********************
; use base 'HO::Tmpl::Markup::TT::element::DATA'

; package HO::Tmpl::Markup::TT::element::CALL
# ********************************************
; our $VERSION = '0.01'
# **********************
; use base 'HO::Tmpl::Markup::TT::element::DATA'

; sub _begin_tag    () { '[% CALL ' } # inline

; package HO::Tmpl::Markup::TT::element::SETTER
# **********************************************
; our $VERSION = '0.01'
# **********************
; use base 'HO::Tmpl::Markup::TT::element::single'

; sub string
    { my ($tag,@thread) = @{$_[0]->_thread}

    ; my $r = $_[0]->_begin_tag . $_[0]->_tag . ' = ' . shift @thread
    ; while(@thread) 
        { $r .= "\n  " . shift(@thread) . ' = ' . shift(@thread)
        }
    ; $r .= $_[0]->_close_stag
    ; return $r
    }

; package HO::Tmpl::Markup::TT::element::SET
# *******************************************
; our $VERSION = '0.01'
# **********************
; use base 'HO::Tmpl::Markup::TT::element::SETTER'

; sub _begin_tag    () { '[% SET ' } # inline

; package HO::Tmpl::Markup::TT::element::DEFAULT
# ***********************************************
; our $VERSION = '0.01'
# **********************
; use base 'HO::Tmpl::Markup::TT::element::DATA'

; sub _begin_tag    () { '[% DEFAULT ' } # inline

; 1

__END__

=head1 DESCRIPTION

=over4

=item C<field>

=item C<current>

=item C<choice>

=back

[% IF age < 10 %]
   Hello [% name %], does your mother know you're 
   using her AOL account?
[% ELSIF age < 18 %]
   Sorry, you're not old enough to enter 
   (and too dumb to lie about your age)
[% ELSE %]
   Welcome [% name %].
[% END %]

package HO::Tag::TT2
# *********************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
; use HO::Tag
; use base 'HO::Tag::Single'

; sub _bopentag () { '[% ' }  # inline
; sub _closetag () { ' %]' }  # inline