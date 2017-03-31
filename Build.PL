use strict;
use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'HO::common',
      dist_version    => '0.64',
      dist_author     => 'Sebastian Knapp <news@young-workers.de>',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      dist_abstract   => 'hierachical (array based) objects',

      requires => { perl => 5.008 }
    )->create_build_script;
