use Renard::Incunabula::Common::Setup;
package Intertangle::API::Gtk3::Helper::Gtk3::Adjustment;
# ABSTRACT: Helpers for Gtk3::Adjustment

package # hide from PAUSE
	Gtk3::Adjustment;

=method increment_step

  method increment_step()

Increments by the step increment.

=cut
method increment_step() {
	my $adjustment = $self->get_value + $self->get_step_increment;
	$self->set_value($adjustment);
	$self;
}

=method decrement_step

  method decrement_step()

Decrements by the step increment.

=cut
method decrement_step() {
	my $adjustment = $self->get_value - $self->get_step_increment;
	$self->set_value($adjustment);
	$self;
}

1;
