#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $count = 0;
while ($count < 10) {
    $count += 2;
    print "count is now $count\n";
}
