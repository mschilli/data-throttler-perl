######################################################################
# Makefile.PL for Data::Throttler
# 2007, Mike Schilli <cpan@perlmeister.com>
######################################################################
use ExtUtils::MakeMaker;

my $mm_ver = $ExtUtils::MakeMaker::VERSION;
if ($mm_ver =~ /_/) { # dev version
    $mm_ver = eval $mm_ver;
    die $@ if $@;
}

my $meta_merge = {
    META_MERGE => {
        resources => {
            repository  => 'http://github.com/mschilli/data-throttler-perl',
        },
    }
};
WriteMakefile(
    'NAME'         => 'Data::Throttler',
    'VERSION_FROM' => 'lib/Data/Throttler.pm', # finds $VERSION
    'PREREQ_PM'    => {
        Set::IntSpan     => 0,
        Log::Log4perl    => 1.0,
        YAML             => 0.62,
        # (optional) Text::ASCIITable => 0,
    }, # e.g., Module::Name => 1.1
    $ExtUtils::MakeMaker::VERSION >= 6.50 ? (%$meta_merge) : (),
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Data/Throttler.pm',
       AUTHOR     => 'Mike Schilli <cpan@perlmeister.com>') : ()),

    ($mm_ver >= 6.31
        ? (LICENSE => 'perl')
        : ()
    ),

    ($mm_ver >= 6.48
        ? (MIN_PERL_VERSION => 5.006)
        : ()
    ),

);
