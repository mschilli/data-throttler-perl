######################################################################
# Test suite for Throttler
# by Mike Schilli <cpan@perlmeister.com>
######################################################################

use warnings;
use strict;

use Test::More qw(no_plan);
use Data::Throttler;

my $throttler = Data::Throttler->new(
    max_items => 2,
    interval  => 60,
);

is($throttler->try_item(), 1, "1st item");
is($throttler->try_item(), 1, "2nd item");
is($throttler->try_item(), 0, "3nd item");

is($throttler->try_item(key => "foobar"), 1, "1st item (key)");
is($throttler->try_item(key => "foobar"), 1, "2nd item (key)");
is($throttler->try_item(key => "foobar"), 0, "3nd item (key)");
