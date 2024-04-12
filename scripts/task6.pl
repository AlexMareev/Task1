#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

sub read_conf {
    my $file_path = shift;
    my %config_hash;

    open( my $fh, '<', $file_path ) or die "Could not open file '$file_path' $!";
    while ( my $line = <$fh> ) {
        chomp $line;

        # Пропускаем строки, начинающиеся с #
        next if $line =~ m/^\s*#/;

        # Удаляем пробелы и табуляции
        $line =~ s/\s+//g;

        # Разбиваем строку на ключ и значение
        my ( $key, $value ) = split /=/, $line, 2;

        # Пропускаем пару, если ключ или значение пустые
        next unless defined $key && defined $value && $key ne '' && $value ne '';

        # Добавляем пару ключ-значение в хэш
        $config_hash{$key} = $value;
    }
    close( $fh );

    return %config_hash;
}

# Пример использования
my %config = read_conf( "conf.ini" );
foreach my $key ( keys %config ) {
    print "$key => $config{$key}\n";
}


