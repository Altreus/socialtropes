package Web::HyperMachine;

use strict;
use warnings;
use 5.010;

use Web::Machine;
use base 'Plack::Component';

use Module::Runtime qw[ use_package_optimistically ];

use Plack::App::Path::Router;
use Path::Router;
use Data::Dumper;

sub new {
    my $self = bless {}, shift;
    $self->{router} = Path::Router->new();

    return $self;
}

sub with {
    my ($self, $resource) = @_;

    use_package_optimistically($resource);

    my $path = '';
    $resource->uri and $path = '/' . $resource->uri . '/?:id/?:related';

    $self->{router}->add_route(
        $path =>
            defaults => {
                id => undef,
                related => undef
            },
            target => $self->machine($resource),
    );
}

sub call {
    my ($self, $env) = @_;

    Plack::App::Path::Router->new( router => $self->{router} )->call($env);
}

sub machine {
    my $self = shift;
    my $resource = shift;

    sub {
        my ($req, $id, $related) = @_;
        if ($related) {
            Web::Machine->new(
                resource => $resource->relation($related),
                resource_args => [
                    related_to => $resource->uri,
                    id => $id,
                    hypermachine => $self,
                ],
            )->call($req->env);
        }
        else {
            Web::Machine->new(
                resource => $resource,
                resource_args => [
                    id => $id,
                    hypermachine => $self,
                ],
            )->call($req->env);
        }
    }
}

1;
