use strict;
use Module::Build;
# See perldoc Module::Build for details of how this works

# this is more a reminder to myself how easy it was to extend the functionality

Module::Build->new
    ( module_name     => 'HO',
      dist_version    => '0.61',
      dist_author     => 'Sebastian Knapp <sk@computer-leipzig.com>',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      dist_abstract   => 'hierachical (array based) objects',

      requires =>
          { perl => 5.008
	  }
    )->create_build_script;
