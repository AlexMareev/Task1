#!/usr/bin/perl
use utf8;
use strict;
use warnings;

# Объявляем массив с именами
my @users_list = ( "Elena", "Alex", "Nikita" );

my $param = $ARGV[0];
print "Parameter for string:$param\n";

#Принимаем имя и пароль через %ENV
my $user_name = $ENV{'user_name'};
my $user_passwd = $ENV{'user_passwd'};

my $find = 0;

# Проверяем пользователя в массиве
foreach my $user ( @users_list ) {
    if ( $user eq $user_name ) {
        $find = 1;
        last;
    }
}
if ( $find == 1 ) {
    print "Welcome, $user_name!\n";
    print "Your password: $user_passwd!\n";
}
else {
    print "Who are you, $user_name!\n";
}



