######################################################################
# Test suite for Throttler
# by Mike Schilli <cpan@perlmeister.com>
######################################################################

use warnings;
use strict;

use Test::More;
use Data::Throttler;
use File::Temp qw(tempfile);

plan tests => 9;

my($fh, $file) = tempfile();
unlink $file;
END { unlink $file };

my $throttler = Data::Throttler->new(
    max_items => 2,
    interval  => 60,
    db_file   => $file,
);

is($throttler->try_push(), 1, "1st item in");
is($throttler->try_push(), 1, "2nd item in");
is($throttler->try_push(), 0, "3nd item blocked");

my $throttler2 = Data::Throttler->new(
    max_items => 999,
    interval  => 1235,
    db_file   => $file,
);

is($throttler->try_push(), 0, "3nd item blocked");
is($throttler2->try_push(), 1, "3nd item in");
is($throttler2->try_push(), 1, "4th item in");

# Reload test
my $throttler3 = Data::Throttler->new(
    max_items => 2,
    interval  => 60,
    db_file   => $file,
    reset     => 1,
);
is($throttler3->try_push(), 1, "1st item in");
is($throttler3->try_push(), 1, "2nd item in");
is($throttler3->try_push(), 0, "3rd item blocked");
