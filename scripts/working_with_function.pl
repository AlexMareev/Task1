#!/usr/bin/perl
use strict;
use warnings;

sub _login {
    my ($user_name, $user_password) = @_;

    # Проверка на пустоту входных параметров
    unless ($user_name && $user_password) {
        print "Ошибка: ";
        print "Не указано имя пользователя\n" unless defined $user_name;
        print "Не указан пароль\n" unless defined $user_password;
        return -1;
    }

    # Проверка пароля пользователя
    my $correct_password = "password123";
    if ($user_password eq $correct_password) {
        return 0; # Пользователь прошел проверку
    }
    else {
        return -1; # Пользователь не прошел проверку
    }
}

# Принимаем параметры из %ENV
my $user_name = $ENV{'USER'};
my $user_password = $ENV{'PASSWORD'};

# Провера в зависимости от результата функции
my $result = _login($user_name, $user_password);
if ($result == 0) {
    print "Пользователь прошел проверку\n";
}
else {
    print "Ошибка: Пользователь не прошел проверку\n";
}

