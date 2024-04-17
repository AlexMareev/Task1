#!/usr/bin/perl
use utf8;
use strict;
use warnings;

sub evaluate_expression {
    my ( $num1, $operator, $num2 ) = @_;

    if ( $operator eq "+" ) {
        return $num1 + $num2;
    }
    elsif ( $operator eq "-" ) {
        return $num1 - $num2;
    }
    elsif ( $operator eq "*" ) {
        return $num1 * $num2;
    }
    elsif ( $operator eq "/" ) {
        # Проверка деления на ноль
        if ( $num2 == 0 ) {
            die "Ошибка: Деление на ноль\n";
        }
        return $num1 / $num2;
    }
    else {
        die "Ошибка: Неверный оператор\n";
    }
}

print "Введите первое число: ";
my $result = <STDIN>;
chomp $result;

my $expression = "$result";
my $last_operator = '';

while ( 1 ) {
    print "Введите оператор или '=' для завершения: ";
    my $operator = <STDIN>;
    chomp $operator;

    last if $operator eq '=';

    print "Введите число: ";
    my $num = <STDIN>;
    chomp $num;

    # Проверка на числовой ввод
    unless ( $num =~ /^\d+$/ ) {
        die "Ошибка: '$num' не является числом\n";
    }

    # Выполнение операции
    my $temp_result = evaluate_expression( $result, $operator, $num );
    if ( ( $operator eq "*" || $operator eq "/" ) && ( $last_operator eq '+' || $last_operator eq '-' ) ) {
        $expression = "($expression) $operator $num";
    }
    else {
        $expression .= " $operator $num";
    }
    $result = $temp_result;
    $last_operator = $operator;
    print "Промежуточный результат: $result\n";
}

print "Итоговый результат: $expression = $result\n";
