#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode( STDOUT, ":utf8" );
use File::Temp qw(tempfile);
use Test::More tests => 15;
use File::Temp;
use FindBin qw($RealBin);
use lib "$RealBin/../scripts";
use tools;

# Временный конфиг файл с тестовыми данными
my ( $fh, $filename ) = File::Temp::tempfile();
print $fh "key1=value1\n";
print $fh "key2=value2\n";
close $fh;

# Тест для read_conf
print "### READ CONF TEST ###\n";
my %config_hash = tools::read_conf( $filename );
is( scalar( keys %config_hash ), 2, 'Read_conf successful' );
print "########################\n\n";

# Тест для reg_user
print "### REG USER TEST ###\n";
my $new_user = 'test_user';
my $password = 'test_password';
my $config_ref = tools::reg_user( $new_user, $password );
ok( defined $config_ref, 'Reg_user successful' );
print "########################\n\n";

# Тест для rewrite_config
print "### REWRITE CONFIG TEST ###\n";
my %new_config_hash = (
    'key1' => 'new value1',
    'key2' => 'new value2',
);
tools::rewrite_config( \%new_config_hash );

my %rewritten_config_hash = tools::read_conf( $tools::conf_path );
is( scalar( keys %rewritten_config_hash ), 2, 'Rewrite_config successful' );
print "########################\n\n";


# Тест для check_user_name
print "### CHECK USER NAME TEST ###\n";
is( tools::check_user_name( "ValidUserName" ), 1, 'Check_user_name successful' );
is( tools::check_user_name( "123Invalid" ), 0, 'Check_user_name fails starting with a number' );
is( tools::check_user_name( "кириллица" ), 0, 'Check_user_name fails with Cyrillic characters' );
print "########################\n\n";

# Тест для check_user_passwd
print "### CHECK PASSWD TEST ###\n";
is( tools::check_user_passwd( "Z\$0123456789ABCDEF" ), 1, 'Check_password successful' );
is( tools::check_user_passwd( "1234567" ), 0, 'Check_password fails less than 8 chars' );
is( tools::check_user_passwd( "\$0123456789ABCDEF" ), 0, 'Check_password fails not starting with alphabet' );
is( tools::check_user_passwd( "Z123456789ABCDEF" ), 0, 'Check_password fails no special symbol' );
is( tools::check_user_passwd( "z\$123456789abcdef" ), 0, 'Check_password fails no uppercase letter' );
is( tools::check_user_passwd( "z\$ABCDEFabcdef" ), 0, 'Check_password fails no digits' );
print "########################\n\n";

# Тест для del_user
print "### DEL USER TEST ###\n";
my $test_user = 'test_user';
my %test_config2 = (
    $test_user => 'test_password'
);
tools::rewrite_config( \%test_config2 );
my $deleted = tools::del_user( $test_user );
ok( $deleted, 'Del_user successful' );
$deleted = tools::del_user( 'nonexistent_user' );
ok( !$deleted, 'Del_user fails for nonexistent user' );
print "########################\n\n";

print "### CHANGE PASSWD TEST ###\n";
my $test_user1 = 'test_user';
my $old_password = 'Old_password1!';
my %test_config = ( $test_user1 => $old_password );
tools::rewrite_config( \%test_config );
my $new_password = 'New_password1!';
my $change_result = tools::change_passwd( $test_user1, $new_password );
ok( $change_result, 'Change_passwd successful' );
print "########################\n\n";

unlink $filename;

done_testing();
