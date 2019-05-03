use Renard::Incunabula::Common::Setup;
package Renard::API::Gtk3::GdkX11;
# ABSTRACT: Load the GdkX11 library

use Glib::Object::Introspection;

my $_GDKX11_BASENAME = 'GdkX11';
my $_GDKX11_VERSION = '3.0';
my $_GDKX11_PACKAGE = __PACKAGE__;

my @_FLATTEN_ARRAY_REF_RETURN_FOR = qw/
/;

sub import {
	Glib::Object::Introspection->setup(
		basename => $_GDKX11_BASENAME,
		version  => $_GDKX11_VERSION,
		package  => $_GDKX11_PACKAGE,
		flatten_array_ref_return_for => \@_FLATTEN_ARRAY_REF_RETURN_FOR,
	);
}

1;
