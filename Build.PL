use strict;
use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'HO::common',
      dist_version    => '0.64',
      dist_author     => 'Sebastian Knapp <sknpp@cpan.org>',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      dist_abstract   => 'hierachical (array based) objects',
      requires =>
          { perl => 5.008
          , 'HO::class' => 0.076
          , parent => 0
          },
      configure_requires => {
          'Module::Build' => 0.42
      },
      build_requires => {
          'Test::More' => 0,
          'Test::Exception' => 0
      },
      add_to_cleanup      => [ 'HO-common-*' ],
      meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-ho-common.git',
            homepage => 'http://github.com/giftnuss/p5-ho-common/tree/master'
        }
      }
    )->create_build_script;
