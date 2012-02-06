
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::Exception" => 0,
    "Test::More" => "0.88"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "generating native linux packages from cpan",
  "dist_author" => [
    "Jerome Quelin <jquelin\@gmail.com>"
  ],
  "dist_name" => "App-CPAN2Pkg",
  "dist_version" => "2.120370",
  "license" => "perl",
  "module_name" => "App::CPAN2Pkg",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "DateTime" => 0,
    "Devel::Platform::Info::Linux" => 0,
    "Exporter::Lite" => 0,
    "File::ShareDir::PathClass" => 0,
    "Find::Lib" => 0,
    "FindBin" => 0,
    "HTML::TreeBuilder" => 0,
    "HTTP::Request" => 0,
    "List::MoreUtils" => 0,
    "List::Util" => 0,
    "Moose" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::ClassAttribute" => 0,
    "MooseX::Has::Sugar" => 0,
    "MooseX::POE" => 0,
    "MooseX::SemiAffordanceAccessor" => 0,
    "MooseX::Singleton" => 0,
    "POE" => 0,
    "POE::Component::Client::HTTP" => 0,
    "POE::Kernel" => 0,
    "POE::Loop::Tk" => 0,
    "POE::Wheel::Run" => 0,
    "Path::Class" => 0,
    "Readonly" => 0,
    "Tk" => 0,
    "Tk::Balloon" => 0,
    "Tk::HList" => 0,
    "Tk::NoteBook" => 0,
    "Tk::PNG" => 0,
    "Tk::ROText" => 0,
    "Tk::Role::HasWidgets" => 0,
    "Tk::Sugar" => 0,
    "perl" => "5.012",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/cpan2pkg"
  ],
  "share_dir" => {
    "dist" => "share"
  }
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
