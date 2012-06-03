package Jobeet::Models;
use strict;
use warnings;
use Ark::Models '-base';

register Schema => sub {
    my $self = shift;
    # Gitのテスト
    # 設定ファイルconf.plの読み込み
    my $conf = $self->get('conf')->{database}
        or die 'require database config';

    $self->ensure_class_loaded('Jobeet::Schema');
    Jobeet::Schema->connect(@$conf);
};

for my $table (qw/Job Category CategoryAffiliate Affiliate/) {
    #Scheme/Result以下にある定義ファイルを読みこんでくれる。
    my @tables = map {
        my $module = $_;
        (my $table = $module) =~ s/Jobeet::Schema::Result:://;
        $table;
    } Module::Find::findallmod('Jobeet::Schema::Result');
    
    # register関数でArkモデルを登録。
    for my $table (@tables) {
        register "Schema::${table}" => sub {
            shift->get('Schema')->resultset($table);
        };
    }
}

1;
