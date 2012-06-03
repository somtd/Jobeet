package Jobeet::Schema::Result::Category;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';


__PACKAGE__->table('jobeet_category');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    name => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['name']);

#リレーションの定義(Category と Jobの関係)
__PACKAGE__->has_many( jobs => 'Jobeet::Schema::Result::Job', 'category_id',
    {
        is_foreign_key_constraint   => 0,
        cascade_delete              => 0,
    },
 );
#リレーションの定義(Category と category_affiliateの関係)
__PACKAGE__->has_many( category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'category_id',
    {
        is_foreign_key_constraint   => 0,
        cascade_delete              => 0,
    },
);
#リレーションの定義(Category と Affiliateの関係)
__PACKAGE__->many_to_many( affiliates => category_affiliate => 'affiliate' );

1;
