package SocialTropes::Storage::SQLite::Result::Trope;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('trope');
__PACKAGE__->add_columns(qw( id title summary content ));
__PACKAGE__->set_primary_key('id');

1;
