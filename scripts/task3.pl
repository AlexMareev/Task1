#!/usr/bin/perl
use utf8;
use strict;
use warnings;

# Объявляем хэш с именами и паролями
my %users_prms = (
    "Elena"  => "111",
    "Alex"   => "222",
    "Nikita" => "333"
);

# Получаем имя пользователя
print "Enter for username: ";
my $user_name = <STDIN>;
chomp( $user_name );

# Проверяем, существует ли введёное имя пользователя в хеше
if ( exists $users_prms{$user_name} ) {
    print "Welcome, $user_name!\n";
    print "Your password: " . $users_prms{$user_name} . "\n";
}
else {
    print "Incorrect login and password.\n";
}