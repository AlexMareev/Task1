#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Функция для поиска файла в директории /newsletter/
sub find_file {
    my $file_name = shift;

    my $directory = "C:/Users/1/IdeaProjects/untitled1/newsletter";
    my $file_path = $directory . '/' . $file_name;

    if ( -e $file_path ) {
        return $file_path;
    }
    else {
        return undef;
    }
}

# Функция для подсчета слов в тексте
sub count_words {
    my $text = shift;

    my @words = split /\s+/, $text;
    return scalar @words;
}

# Функция для подсчета повторяющихся слов и их вывода в порядке убывания
sub count_and_sort_words {
    my $text = shift;

    my %word_count;
    foreach my $word ( split /\s+/, $text ) {
        $word_count{$word}++;
    }

    my @sorted_words = sort { $word_count{$b} <=> $word_count{$a} || $a cmp $b } keys %word_count;
    @sorted_words = grep { $word_count{$_} > 2 } @sorted_words; # Изменено здесь

    return (\@sorted_words, \%word_count);
}

# Функция для проверки текста на наличие неприличных слов
sub check_bad_words {
    my $text = shift;

    my @bad_words = qw(мат оскорбление неприличное); # Плохие слова, можно расширить список

    foreach my $bad_word ( @bad_words ) {
        if ( $text =~ /\b$bad_word\b/i ) {
            return 1; # Найдено неприличное слово
        }
    }

    return 0; # Неприличных слов не найдено
}

# Главная программа

# Проверяем, передан ли аргумент командной строки (название файла)
unless ( @ARGV ) {
    die "Ошибка: Не указано название файла\n";
}

my $file_name = shift @ARGV;

# Пытаемся найти файл
my $file_path = find_file( $file_name );
unless ( defined $file_path ) {
    die "Файл '$file_name' не найден в директории /newsletter/\n";
}

# Читаем содержимое файла
open( my $fh, '<', $file_path ) or die "Ошибка: Не удалось открыть файл '$file_path': $!\n";
my $file_content = do {
    local $/;
    <$fh>
};
close( $fh );

# Удаляем символы переноса строки
$file_content =~ s/-\n//g;

# 1) Считаем количество слов в тексте
my $word_count = count_words($file_content);
print "В тексте найдено $word_count слов\n";

# 2) Считаем и выводим слова, которые повторяются более 2 раз
my ($sorted_words_ref, $word_count_ref) = count_and_sort_words($file_content);
my @sorted_words = @$sorted_words_ref;
my %word_count = %$word_count_ref;
if (@sorted_words) {
    print "Слова, повторяющиеся более 2 раз:\n";
    foreach my $word (@sorted_words) {
        print "$word: $word_count{$word} раз\n";
    }
} else {
    print "В тексте нет слов, повторяющихся более 2 раз\n";
}


# 3) Проверяем текст на наличие неприличных слов
if ( check_bad_words( $file_content ) ) {
    print "В тексте обнаружены неприличные слова\n";
}
else {
    print "Неприличные слова в тексте не обнаружены\n";
}
