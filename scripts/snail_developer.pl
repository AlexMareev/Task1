#!/usr/bin/perl
use utf8;
use strict;
use warnings;
use POSIX;

sub calculate_sprints {
    my ( $total_tasks, $a, $b ) = @_;
    # Вычисляем количество спринтов
    my $sprints = ceil( $total_tasks / ( ( $a - $b ) * 10 ));
    # Если скорость решения задач меньше скорости прихода новых задач, возвращаем 0
    return $a > $b ? $sprints : 0;
}

my $total_tasks = 100; # общее количество задач
my $a = 9;             # скорость решения в день
my $b = 6;             # скорость прихода новых задач в день

my $sprints = calculate_sprints( $total_tasks, $a, $b );

print $sprints > 0 ? "Улитка справится за $sprints спринтов\n" : "Улитка не справится\n";
