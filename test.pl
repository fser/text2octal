#!/usr/bin/env perl

use strict;
use Data::Dumper;

# require "text2octal.pl";

# print Dumper(bloc2struct('-', '-', '-'));
# print Dumper(bloc2struct('r', '-', '-'));
# print Dumper(bloc2struct('r', 'w', '-'));
# print Dumper(bloc2struct('r', 'w', 'x'));
# print Dumper(bloc2struct('-', 'w', '-'));
# print Dumper(bloc2struct('-', 'w', 'x'));
# print Dumper(bloc2struct('-', '-', 'x'));
# print Dumper(bloc2struct('r', '-', 'x'));
# print Dumper(bloc2struct('-', '-', 's'));
# print Dumper(bloc2struct('-', '-', 'S'));

my $foo = {'bar' => 42 };
$foo->{'bar'} = 24;
print $foo->{'bar'};
