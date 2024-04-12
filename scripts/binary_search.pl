#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

sub binary_search {
    my ( $array_ref, $target ) = @_;

    my $left_index = 0;
    my $right_index = $#$array_ref;

    while ( $left_index <= $right_index ) {
        my $middle_index = int( ( $left_index + $right_index ) / 2 );
        my $middle_value = $array_ref->[$middle_index];

        if ( $middle_value == $target ) {
            return $middle_index;
        }
        elsif ( $middle_value < $target ) {
            $left_index = $middle_index + 1;
        }
        else {
            $right_index = $middle_index - 1;
        }
    }

    return -1;
}

# Отсортированный массив
my @sorted_array = ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 );

print "Sorted array: @sorted_array\n";

print "Enter a value to search for: ";
chomp( my $input = <STDIN> );

if ( $input =~ /^[+-]?\d+$/ ) {
    # Пользователь ввел непустую строку без спецсимволов
    my $index = binary_search( \@sorted_array, $input );
    if ( $index != -1 ) {
        print "$input found at index $index\n";
    }
    else {
        print "$input not found in the array\n";
    }
}
else {
    print "Invalid input. Please enter a valid value.\n";
}