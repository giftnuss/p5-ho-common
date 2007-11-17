
; my @args

; BEGIN
    { eval { require Test::MinimumVersion; }
    ; if( $@ )
        { push @args, skip_all => "Test::MinimumVersion is not installed!"
        }
      else
        { push @args, tests => 1
        }
    }

; use Test::More @args

; Test::MinimumVersion::minimum_version_ok('lib/HO.pm', '5.006')
