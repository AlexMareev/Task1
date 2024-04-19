#!/usr/bin/perl
use utf8;
use strict;
use warnings;

my $conf_path = 'C:/Users/1/IdeaProjects/untitled1/conf.ini';
sub _read_conf {
    my $file_path = shift;

    # Открываем файл
    open( my $fh, '<', $file_path )
        or die "Ошибка: Не удалось открыть файл '$file_path': $!\n";

    # Читаем файл в массив
    my @conf_array = <$fh>;

    close( $fh );

    return @conf_array;
}
# Создаем хэш для записи в файл
my %conf_hash = (
    "alex" => "1234",
    "nic"  => "2345"
);

# Записываем хэш в файл
open( my $write_fh, '>', $conf_path )
    or die "Ошибка: Не удалось создать файл '$conf_path': $!\n";
foreach my $key ( keys %conf_hash ) {
    print $write_fh "$key=$conf_hash{$key}\n";
}
close( $write_fh );

# Читаем файл в массив
my @conf_content = _read_conf( $conf_path );

foreach my $line ( @conf_content ) {
    print $line;
}