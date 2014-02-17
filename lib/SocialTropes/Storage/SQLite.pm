package SocialTropes::Storage::SQLite;

use strict;
use warnings;

use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_namespaces();

sub get_connection {
    return shift->connect('dbi:SQLite:./my.db');
}
1;
