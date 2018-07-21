use strict;
use Module::Build;
# See perldoc Module::Build for details of how this works

# this is more a reminder to myself how easy it was to extend the functionality

Module::Build->new
    ( module_name     => 'HO::common',
      dist_version    => '0.61',
      dist_author     => 'Sebastian Knapp <sknpp@cpan.org>',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      dist_abstract   => 'hierachical (array based) objects',

      requires =>
          { perl => 5.008
          , HO::class => 0.072
	  }
    )->create_build_script;
