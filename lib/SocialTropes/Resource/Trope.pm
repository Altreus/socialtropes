package SocialTropes::Resource::Trope;

use strict;
use warnings;
use 5.010;

use Data::Dumper;
use SocialTropes::Storage::SQLite;

use base 'Web::HyperMachine::Resource';

__PACKAGE__->uri('trope');

sub content_types_provided {
    [
        {
            'text/html' => 'to_html'
        }
    ]
}

sub to_html {
    my $self = shift;
    my $html = '';

    print "To HTML";
    while (my $row = $self->{resource}->next) {
        $html .= '<h1>' . $row->title . '</h1>';
    }

    $html or $html = 'No data';

    $html;
}

sub fetch {
    my $self = shift;
    my ($id) = @_;

    my $query = SocialTropes::Storage::SQLite->get_connection
        ->resultset('Trope');

    if ($id) {
        $query = $query->search({ id => $id });
    }

    # 404 on a zero count but only if we supply ID
    if (! $id or $query->count) {
        return $query;
    }

    return undef;
}

1;
