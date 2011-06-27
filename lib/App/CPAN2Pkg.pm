#
# This file is part of App-CPAN2Pkg
#
# This software is copyright (c) 2009 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.012;
use strict;
use warnings;

package App::CPAN2Pkg;
BEGIN {
  $App::CPAN2Pkg::VERSION = '2.111780';
}
# ABSTRACT: generating native linux packages from cpan

# although it's not strictly needed to load POE::Kernel manually (since
# MooseX::POE will load it anyway), we're doing it here to make sure poe
# will use tk event loop. this can also be done by loading module tk
# before poe, for example if we load app::cpan2pkg::tk::main before
# moosex::poe... but better be safe than sorry, and doing things
# explicitly is always better.
use POE::Kernel { loop => 'Tk' };

use MooseX::Singleton;
use MooseX::Has::Sugar;
use Readonly;

use App::CPAN2Pkg::Controller;
use App::CPAN2Pkg::Tk::Main;
use App::CPAN2Pkg::Utils      qw{ $LINUX_FLAVOUR $WORKER_TYPE };

use POE;

# -- private attributes

# keep track of modules being processed.
has _modules => (
    ro,
    isa     => 'HashRef[App::CPAN2Pkg::Module]',
    traits  => ['Hash'],
    handles => {
        all_modules     => 'keys',
        seen_module     => 'exists',
        register_module => 'set',
        module          => 'get',
    }
);


# -- public methods


# those methods above are provided by moose traits for free



sub run {
    my (undef, @modules) = @_;

    # check if the platform is supported
    eval "require $WORKER_TYPE";
    die "Platform $LINUX_FLAVOUR is not supported" if $@ =~ /^Can't locate/;
    die $@ if $@;

    # create the poe sessions
    App::CPAN2Pkg::Controller->new( queue=>\@modules );
    App::CPAN2Pkg::Tk::Main->new;

    # and let's start the fun!
    POE::Kernel->run;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;


=pod

=head1 NAME

App::CPAN2Pkg - generating native linux packages from cpan

=head1 VERSION

version 2.111780

=head1 SYNOPSIS

    $ cpan2pkg
    $ cpan2pkg Module::Foo Module::Bar ...

=head1 DESCRIPTION

Don't use this module directly, refer to the C<cpan2pkg> script instead.

C<App::CPAN2Pkg> is the main entry point for the C<cpan2pkg> application. It
also provides some information about processed modules.

=head1 METHODS

=head2 all_modules

    my @modules = $app->all_modules;

Return the list of all modules that have been / are being processed.

=head2 seen_module

    my $bool = $app->seen_module( $modname );

Return true if C<$modname> has already been seen. It can be either
finished processing, or still ongoing.

=head2 register_module

    $app->register_module( $modname, $module );

Store C<$module> as the L<App::CPAN2Pkg::Module> object tracking
C<$modname>.

=head2

    my $module = $app->module( $modname );

Return the C<$module> object registered for C<$modname>.

=head2 run

    App::CPAN2Pkg->run( [ @modules ] );

Start the application, with an initial batch of C<@modules> to build.

=head1 BUGS

Please report any bugs or feature requests to C<app-cpan2pkg at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-CPAN2Pkg>. I will
be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SEE ALSO

You can look for information on this module at:

=over 4

=item * Search CPAN

L<http://search.cpan.org/dist/App-CPAN2Pkg>

=item * See open / report bugs

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-CPAN2Pkg>

=item * Git repository

L<http://github.com/jquelin/app-cpan2pkg>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-CPAN2Pkg>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-CPAN2Pkg>

=back

=head1 AUTHOR

Jerome Quelin <jquelin@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

