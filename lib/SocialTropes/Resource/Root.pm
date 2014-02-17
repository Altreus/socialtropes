package SocialTropes::Resource::Root;

use strict;
use warnings;

use base 'Web::HyperMachine::Resource';

__PACKAGE__->uri('');
__PACKAGE__->related('SocialTropes::Resource::Trope');

sub content_types_provided {
    [
        { 'text/html' => 'to_html' }
    ]
}

sub to_html {
    my $self = shift;
    q{<h1>html</h1>};
}

sub resource_exists { 1 }

1;
