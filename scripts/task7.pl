#!/usr/bin/perl
use utf8;
use strict;
use warnings;

# Добавляем текущую директорию в @INC
use FindBin qw($RealBin);
use lib $RealBin;

# Затем подключаем модуль
use tools;

# Пример использования функции read_conf из модуля tools
my %config = tools::read_conf( $tools::conf_path );
foreach my $key ( keys %config ) {
    print "$key => $config{$key}\n";
}