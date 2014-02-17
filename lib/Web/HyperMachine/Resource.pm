package Web::HyperMachine::Resource;

use strict;
use warnings;

use base qw(Web::Machine::Resource);

use Module::Runtime qw[ use_package_optimistically ];
use Data::Dumper;

my %uri;
my %related;

sub uri {
    my $package = shift;
    $uri{$package} = shift if @_;
    $uri{$package};
}

sub related {
    my $package = shift;
    my $related = shift;

    if ($related) {
        use_package_optimistically($related);
        $related{$package}{$related->uri} = $related;
    }

    return $related{$package};
}

sub relation {
    my $package = shift;
    my $related = shift;

    if (ref $package) {
        $package = ref $package;
    }

    return $related{$package}{$related};
}

sub init {
    my ($self, $args) = @_;
    @{$self}{qw(id related related_to)} = @{$args}{qw(id related related_to)};

    if (defined $self->{related_to}) {
        my $method = 'for_related_' . $self->{related_to};
        if ($self->can($method)) {
            $self->{resource} = $self->$method($self->{id})
        }
        else {
            $self->{resource} = undef;
        }
    }
    else {
        $self->{resource} = $self->fetch($self->{id});
    }

    $self->SUPER::init();
}

sub resource_exists {
    my $self = shift;

    return 0 if not $self->SUPER::resource_exists();

    if (exists $self->{resource}) {
        return defined $self->{resource};
    }

    return 1;
}

sub fetch {}

1;
