######################################################################
# Test suite for Throttler
# by Mike Schilli <cpan@perlmeister.com>
######################################################################

use warnings;
use strict;

use Test::More;
use Data::Throttler;

plan tests => 7;

my $throttler = Data::Throttler->new(
    max_items => 2,
    interval  => 60,
);

is($throttler->try_push(), 1, "1st item");
is($throttler->try_push(), 1, "2nd item");
is($throttler->try_push(), 0, "3nd item");

is($throttler->try_push(key => "foobar"), 1, "1st item (key)");
is($throttler->try_push(key => "foobar"), 1, "2nd item (key)");
is($throttler->try_push(key => "foobar"), 0, "3nd item (key)");

$throttler = Data::Throttler->new(
    max_items => 2,
    interval  => 20,
);

$throttler->try_push() for (1..3);
sleep(2);
is($throttler->try_push(), 1, "1st item after sleep");
