######################################################################
# Test suite for Throttler
# by Mike Schilli <cpan@perlmeister.com>
######################################################################
use warnings;
use strict;

use Test::More;
use Data::Throttler;
use File::Temp qw(tempfile);

# use Log::Log4perl qw(:easy);
# Log::Log4perl->easy_init($DEBUG);

plan tests => 9;

my($fh, $file) = tempfile();
unlink $file;
END { unlink $file };

#BUG RT47189 
my $th = Data::Throttler->new(
        max_items => 10,
        interval  => 3600,
);

for(1..3) {
    $th->try_push( key  => "wonk",
                   time => time()-720,
                  );
}

for(1..5) {
    my $rc = $th->try_push( 
            key  => "wonk",
            time => time(),
    );
    is($rc, 1, "push ok");
    # print $th->buckets_dump();
}
