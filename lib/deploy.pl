use strict;
use warnings;
use lib 'lib';

use Jobeet::Schema;
$ENV{DBIC_TRACE} = 1;

# dbがsqliteのとき
my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');

# dbがMySQLのとき
#　my $schema = Jobeet::Schema->connect(
#    'dbi:mysql:database_name',
#    'username',
#    'password',
#);

my $category_rs = $schema->resultset('Category');
my $category = $category_rs->create({
    name => 'new category',
});

print $category_rs->count;

