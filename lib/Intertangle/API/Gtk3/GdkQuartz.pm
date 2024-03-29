use Renard::Incunabula::Common::Setup;
package Intertangle::API::Gtk3::GdkQuartz;
# ABSTRACT: Load the GdkQuartz library

use FFI::Platypus;
use FFI::CheckLib 0.06;

my $ffi;
sub import {
	local $SIG{__WARN__} = sub { warn $_[0] unless $_[0] =~ /Subroutine \Q@{[ __PACKAGE__ ]}\E.* redefined/ };

	# Need to attach the `gdk_quartz_window_get_nsview` function.
	$ffi ||= do {
		my $ffi = FFI::Platypus->new;


		$ffi->lib(find_lib_or_die lib => 'gdk-3');
		# NSView * gdk_quartz_window_get_nsview (GdkWindow *window)
		$ffi->attach( gdk_quartz_window_get_nsview => [ 'opaque' ], 'opaque', sub {
			my ($xs, $gdk_window) = @_;
			Gtk3::Gdk::threads_enter();
			my $view = $xs->( Glib::Object::get_pointer($gdk_window) );
			Gtk3::Gdk::threads_leave();
			return $view;
		});

		$ffi;
	};
}

1;
