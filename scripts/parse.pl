#!/usr/bin/perl
use strict;
use warnings;
use XML::Simple;
use Data::Dumper;

my $file_path = 'C:\Users\1\IdeaProjects\untitled1\fail.xml';

my $xml = XML::Simple->new();
my $data = $xml->XMLin( $file_path );

my @employees = @{ $data->{employee_name} };
my @positions = @{ $data->{employee_position} };
my @salaries = @{ $data->{employee_salary} };

for ( my $i = 0; $i < scalar @employees; $i++ ) {
    my $employee = $employees[$i];
    my $position = $positions[$i];
    my $salary = $salaries[$i];

    print "$employee, $position, $salary\n";
}
