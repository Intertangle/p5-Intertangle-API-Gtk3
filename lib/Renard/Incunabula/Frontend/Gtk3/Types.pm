use Renard::Incunabula::Common::Setup;
package Renard::Incunabula::Frontend::Gtk3::Types;
# ABSTRACT: Type library for Gtk3

use Type::Library 0.008 -base,
	-declare => [qw(
		SizeRequest
	)];
use Type::Utils -all;

# Listed here so that scan-perl-deps can find them
use Types::Standard        qw(Tuple);
use Types::Common::Numeric qw(PositiveInt);

=type SizeRequest

A tuple that represents a size request for a widget.

=cut
declare "SizeRequest",
	parent => Tuple[PositiveInt,PositiveInt];

1;
