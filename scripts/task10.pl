#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Добавляем текущую директорию в @INC
use FindBin qw($RealBin);
use lib $RealBin;

# Затем подключаем модуль
use tools;

# Получаем входной параметр "action"
my $action = shift || " ";

# Проверяем значение параметра
if ($action eq 'log') {
    print "Для входа использовать функцию login\n";
} elsif ($action eq 'reg') {
    # Вызываем функцию для регистрации
    my $updated_config = tools::reg_user();
    if ( defined $updated_config ) {
        tools::rewrite_config($updated_config);
        print "Новый пользователь успешно добавлен\n";
    }
} elsif ($action eq 'del') {
    # Вызываем функцию для удаления пользователя
    my $user_name = shift || die "Ошибка: Не указано имя пользователя для удаления\n";
    tools::del_user($user_name);
} else {
    # Если значение параметра не корректно выводим ошибку и завершаем работу скрипта
    die "Ошибка: Значение параметра 'action' не корректно. Допустимые значения: log, reg, del\n";
}
