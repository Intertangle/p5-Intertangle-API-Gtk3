use Renard::Incunabula::Common::Setup;
package Renard::API::Gtk3;
# ABSTRACT: Provides helpers for dealing with Gtk3 code

=method Inline

  use Inline C with => qw(Renard::API::Gtk3);

Returns the flags needed to configure L<Inline::C> to use with
C<gtk+-3.0>.


=cut
sub Inline {
	return unless $_[-1] eq 'C';

	my $gtk3_pkg = 'gtk+-3.0';

	require ExtUtils::PkgConfig;
	require Renard::API::Glib;
	require Hash::Merge;
	my $glib = Renard::API::Glib->Inline($_[-1]);

	my @nosearch = $^O eq 'MSWin32' ? (':nosearch') : ();
	my @search   = $^O eq 'MSWin32' ? ( ':search' ) : ();
	my $gtk = {
		CCFLAGSEX => join(" ", delete $glib->{CCFLAGSEX}, ExtUtils::PkgConfig->cflags($gtk3_pkg)),
		LIBS => join(" ", @nosearch, delete $glib->{LIBS}, ExtUtils::PkgConfig->libs($gtk3_pkg), @search),
		AUTO_INCLUDE => <<C,
#include <gtk/gtk.h>
C
	};

	my $merge = Hash::Merge->new('RETAINMENT_PRECEDENT');
	$merge->merge( $glib, $gtk );
}

1;

__END__

=head1 SEE ALSO

L<Repository information|http://project-renard.github.io/doc/development/repo/p5-Renard-API-Gtk3/>
