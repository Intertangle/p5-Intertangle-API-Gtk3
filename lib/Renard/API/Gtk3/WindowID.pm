use Renard::Incunabula::Common::Setup;
package Renard::API::Gtk3::WindowID;
# ABSTRACT: Module to help obtain the window ID

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Module::Load;

=method get_widget_id

  method get_widget_id( (InstanceOf['Gtk3::Widget']) $widget )

Retrieves platform-specific windows ID / handle which can be used for
re-parenting windows.

=cut
method get_widget_id( (InstanceOf['Gtk3::Widget']) $widget ) {
	my $gdk_window = $widget->get_window;

	# Check both ISA because of loading of GIR happens after.
	if( $gdk_window->isa('Glib::Object::_Unregistered::GdkX11Window')
		|| $gdk_window->isa('Renard::API::Gtk3::GdkX11::X11Window')
	) {
		autoload 'Renard::API::Gtk3::GdkX11';
		return Renard::API::Gtk3::GdkX11::X11Window::get_xid( $gdk_window );
	} elsif( $gdk_window->isa('Glib::Object::_Unregistered::GdkWin32Window')
		|| $gdk_window->isa('Renard::API::Gtk3::GdkWin32::Win32Window')
	) {
		autoload 'Renard::API::Gtk3::GdkWin32';
		return Renard::API::Gtk3::GdkWin32::gdk_win32_window_get_handle( $gdk_window );
	} elsif( $gdk_window->isa('Glib::Object::_Unregistered::GdkQuartzWindow') ) {
		autoload 'Renard::API::Gtk3::GdkQuartz';
		return Renard::API::Gtk3::GdkQuartz::gdk_quartz_window_get_nsview( $gdk_window );
	} else {
		die "Unknown GdkWindow type: $gdk_window";
	}
}

1;
