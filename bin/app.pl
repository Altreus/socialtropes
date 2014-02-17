#!/usr/bin/env perl

use strict;
use warnings;

use Web::HyperMachine;

#use Data::Dumper;
#use Sub::WrapPackages
#    packages => [ 'SocialTropes::Resource::Trope' ],
#    pre      => sub {
#        no warnings 'uninitialized';
#        print "called $_[0] with params ".
#        join(', ', @_[1..$#_])."\n";
#    },
#    post     => sub {
#        no warnings 'uninitialized';
#        print "$_[0] returned $_[1]\n";
#    };
my $machine = Web::HyperMachine->new();

$machine->with('SocialTropes::Resource::Trope');
$machine->with('SocialTropes::Resource::Root');

$machine->to_app;
