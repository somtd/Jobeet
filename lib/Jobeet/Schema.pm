package Jobeet::Schema;
use strict;
use warnings;
use parent 'DBIx::Class::Schema';
use DateTime;

our $VERSION = '1';

__PACKAGE__->load_namespaces;

__PACKAGE__->load_components('Schema::Versioned');
__PACKAGE__->upgrade_directory('sql/');

my $TZ = DateTime::TimeZone->new(name => 'Asia/Tokyo');
#タイムゾーンを返す
sub TZ  {$TZ}
#現在時刻を返す
sub now  {DateTime->now(time_zone => shift->TZ)}
sub today  {shift->now->truncate(to => 'day')}

1;
