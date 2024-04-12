package tools;

use strict;
use warnings;

our $conf_path = 'C:/Users/1/IdeaProjects/untitled1/conf.ini';

sub read_conf {
    my $file_path = shift;
    my %config_hash;

    open( my $fh, '<', $file_path ) or die "Could not open file '$file_path' $!";
    while ( my $line = <$fh> ) {
        chomp $line;

        # Пропускаем строки, начинающиеся с #
        next if $line =~ /^\s*#/;

        # Удаляем пробелы и табуляции
        $line =~ s/[\t\s]//g;

        # Разбиваем строку на ключ и значение
        my ( $key, $value ) = split /=/, $line, 2;

        # Пропускаем пару, если ключ или значение пустые
        next unless $key && $value;

        # Добавляем пару ключ-значение в хэш
        $config_hash{$key} = $value;
    }
    close( $fh );

    return %config_hash;
}

sub reg_user {
    my %config = read_conf( $conf_path );

    print "Введите логин нового пользователя: ";
    my $new_user = <STDIN>;
    chomp $new_user;

    if ( check_user_name( $new_user ) == 0 ) {
        return undef;
    }

    if ( exists $config{$new_user} ) {
        print "Пользователь с логином '$new_user' уже зарегистрирован\n";
        return undef; # Возвращаем undef, чтобы показать, что регистрация не удалась
    }
    elsif ( $new_user eq '' ) {
        print "Логин не может быть пустым\n";
        return undef; # Возвращаем undef, чтобы показать, что регистрация не удалась
    }
    else {
        print "Введите пароль для нового пользователя '$new_user': ";
        my $password = <STDIN>;
        chomp $password;

        if ( check_user_passwd( $password ) == 0 ) {
            return undef;
        }

        $config{$new_user} = $password;
        return \%config; # Возвращаем измененный хэш для записи в файл
    }
}


sub rewrite_config {
    my ( $config_ref ) = @_;

    open( my $fh, '>', $conf_path ) or die "Could not open file '$conf_path' $!";
    foreach my $key ( keys %$config_ref ) {
        print $fh "$key=$config_ref->{$key}\n";
    }
    close( $fh );
}
sub check_user_name {
    my $user_name = shift;

    if ( $user_name =~ /^[a-zA-Z][a-zA-Z0-9_-]*[a-zA-Z0-9]$/ ) {
        return 1;
    }
    else {
        print "Логин должен начинаться с буквы, может содержать цифры,
        не должен содержать спецсимволов, кроме знака тире и нижнего подчеркивания,
        и должен заканчиваться на цифру или букву. Кириллица не допускается.\n";
        return 0;
    }

}
sub check_user_passwd {
    my $password = shift;

    if ( length( $password ) < 8 ) {
        print "Пароль должен содержать не менее 8 символов.\n";
        return 0;
    }

    unless ( $password =~ /^[a-zA-Z]/ ) {
        print "Пароль должен начинаться с латинской буквы.\n";
        return 0;
    }

    unless ( $password =~ /[!@#$%^&*()]/ ) {
        print "Пароль должен содержать минимум один спецсимвол из списка !@#$%^&*().\n";
        return 0;
    }

    unless ( $password =~ /[A-Z]/ ) {
        print "Пароль должен содержать минимум один символ в верхнем регистре.\n";
        return 0;
    }

    unless ( $password =~ /[0-9]/ ) {
        print "Пароль должен содержать минимум одну цифру.\n";
        return 0;
    }

    return 1;
}

sub del_user {
    my $user_name = shift;
    my %config = read_conf($conf_path);

    if (exists $config{$user_name}) {
        delete $config{$user_name};
        rewrite_config(\%config);
        print "Пользователь '$user_name' успешно удален\n";
        return 1;
    } else {
        print "Пользователь с логином '$user_name' не найден\n";
        return 0;
    }
}

1;
