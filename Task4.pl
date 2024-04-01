#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

#Создаём массив
my @array = (9, 5, 7, 1, 8, 3, 6, 10, 4, 2);
print "Source array: @array\n";

for my $i (0 .. $#array) {          #Внешний цикл проходит по всем элементам массива
    for my $j ($i + 1 .. $#array) { #Внутренний идёт по элементам, начиная с эл. следующего за текущем
        if ($array[$i] > $array[$j]) {
            #сли текущий больше следующего, выполняется условие
            my $temporary = $array[$i];
            $array[$i] = $array[$j];
            $array[$j] = $temporary
        }
    }
}

print "Sorted array: @array\n";
