#!/usr/bin/perl
use strict;
use warnings;

# Объявляем массив с именами пользователей
my @users_list = ("Alice", "Bob", "Charlie");

# Получаем имя пользователя из командной строки
print "Введите имя пользователя: ";
my $user_name = <STDIN>;
chomp($user_name); # Убираем символ перевода строки

# Переменная для отслеживания, найден ли пользователь
my $find = 0;

# Перебираем пользователей в массиве
foreach my $user (@users_list) {
    if ($user eq $user_name) {
        $find = 1;
        last; # Прерываем цикл, если пользователь найден
    }
}

# Выводим сообщение в зависимости от результата поиска
if ($find) {
    print "Добро пожаловать, $user_name!\n";
} else {
    print "Ты кто такой, $user_name?!\n";
}
