#!/usr/bin/perl
use utf8;
use strict;
use warnings;

#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Добавляем текущую директорию в @INC
use FindBin qw($RealBin);
use lib $RealBin;

# Затем подключаем модуль
use tools;

# Проверяем количество аргументов
if (@ARGV == 0 || @ARGV == 1) {
    print "######################################################\n";
    print "#back_end.pl usage\n";
    print "# action=reg user_name=NAME user_passwd=PASSWD ./task12.pl - registration new user in system;\n";
    print "#action=log user_name=NAME user_passwd=PASSWD ./task12.pl - login in system\n";
    print "#action=del user_name=NAME ./task12.pl - remove user from system\n";
    print "#action=change_passwd user_name=NAME user_passwd=PASSWD ./back_end.pl - change user password\n";
    print "######################################################\n";
    exit;
}

# Получаем входной параметр "action"
my $action = shift || " ";

# Проверяем значение параметра
if ( $action eq 'log' ) {
    print "Для входа использовать функцию login\n";
}
elsif ( $action eq 'reg' ) {
    # Вызываем функцию для регистрации
    my $updated_config = tools::reg_user();
    if ( defined $updated_config ) {
        tools::rewrite_config( $updated_config );
        print "Новый пользователь успешно добавлен\n";
    }
}
elsif ( $action eq 'del' ) {
    # Вызываем функцию для удаления пользователя
    my $user_name = shift || die "Ошибка: Не указано имя пользователя для удаления\n";
    tools::del_user( $user_name );
}
elsif ( $action eq 'change_passwd' ) {
    # Вызываем функцию для изменения пароля
    my $user_name = shift || die "Ошибка: Не указано имя пользователя для изменения пароля\n";
    my $new_passwd = shift || die "Ошибка: Не указан новый пароль\n";
    tools::change_passwd( $user_name, $new_passwd );
}
else {
    # Если значение параметра не корректно выводим ошибку и завершаем работу скрипта
    die "Ошибка: Значение параметра 'action' не корректно. Допустимые значения: log, reg, del, change_passwd\n";
}
