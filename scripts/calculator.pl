#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

print "Введите первое число: ";
my $num1 = <STDIN>;
chomp $num1;

print "Введите оператор: ";
my $operator = <STDIN>;
chomp $operator;

print "Введите второе число: ";
my $num2 = <STDIN>;
chomp $num2;

# Проверка на числовой ввод
unless ($num1 =~ /^\d+$/) {
    die "Ошибка: '$num1' не является числом\n";
}

unless ($num2 =~ /^\d+$/) {
    die "Ошибка: '$num2' не является числом\n";
}

my $result;
if ($operator eq "+") {
    $result = $num1 + $num2;
} elsif ($operator eq "-") {
    $result = $num1 - $num2;
} elsif ($operator eq "*") {
    $result = $num1 * $num2;
} elsif ($operator eq "/") {
    # Проверка деления на ноль
    if ($num2 == 0) {
        die "Ошибка: Деление на ноль\n";
    }
    $result = $num1 / $num2;
} else {
    die "Ошибка: Неверный оператор\n";
}

print "\n";
print "$num1 $operator $num2 = $result\n";