#!/usr/bin/perl
use strict;
use warnings;

# Объявляем массив с именами
my @users_list = ("Elena", "Alex", "Nikita");

# Получаем имя пользователя
print "Enter for username: ";
my $user_name = <STDIN>;
chomp($user_name); # Убираем символ перевода строки

my $find = 0;

# Проверяем пользователя в массиве
foreach my $user (@users_list) {
    print "Processing with user $user from \@users_list\n";
    if ($user eq $user_name) {
        $find = 1;
        last;
    }
}

if ($find == 1) {
    print "Welcome, $user_name!\n";
}
else {
    print "Who are you, $user_name?!\n";
}
