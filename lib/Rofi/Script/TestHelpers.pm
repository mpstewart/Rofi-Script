package Rofi::Script::TestHelpers;
use strict;
use warnings;

use Carp qw( croak );

use Test2::API qw( context );

use base 'Exporter';

## no critic (ProhibitAutomaticExportation)
our @EXPORT = qw(
  rofi_shows
);

# need a rofi object
use Rofi::Script;

## no critic (ProhibitSubroutinePrototypes)
sub rofi_shows($$;$) {
    my ($want, $name) = @_;

    my $shown = '';
    open my $show_handle, '>', \$shown
        or croak "Could not open show handle";
    rofi->set_show_handle($show_handle);

    rofi->show();

    close $show_handle;

    my $ctx = context();    # Get a context
    if ($shown eq $want) {
        $ctx->pass_and_release($name);
    }
    else {
        my $diag = sprintf(<<"DIAG", $want, $shown);
Wanted:
-------
%s

but got:
--------
%s
DIAG

        $ctx->fail_and_release($name, $diag);
    }

    return $shown;
}


1;
