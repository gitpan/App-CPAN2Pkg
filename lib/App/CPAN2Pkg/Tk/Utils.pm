#
# This file is part of App-CPAN2Pkg
#
# This software is copyright (c) 2009 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.010;
use strict;
use warnings;

package App::CPAN2Pkg::Tk::Utils;
{
  $App::CPAN2Pkg::Tk::Utils::VERSION = '2.120370';
}
# ABSTRACT: Tk utilities for gui building

use Exporter::Lite;
use POE;

use App::CPAN2Pkg::Utils qw{ $SHAREDIR };

our @EXPORT = qw{ image };


# -- public subs


sub image {
    my ($path, $toplevel) = @_;
    $toplevel //= $poe_main_window;
    my $img = $poe_main_window->Photo($path);
    return $img if $img->width;
    return $toplevel->Photo("$toplevel-$path", -file=>$path);
}


1;


=pod

=head1 NAME

App::CPAN2Pkg::Tk::Utils - Tk utilities for gui building

=head1 VERSION

version 2.120370

=head1 DESCRIPTION

This module exports some useful subs for tk guis.

=head1 METHODS

=head2 image

    my $img = image( $path [, $toplevel ] );

Return a tk image loaded from C<$path>. If the photo has already been
loaded, return a handle on it. If C<$toplevel> is given, it is used as
base window to load the image.

=head1 AUTHOR

Jerome Quelin <jquelin@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


