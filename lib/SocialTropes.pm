package SocialTropes;
use Dancer ':syntax';

use SocialTropes::Resource::Trope;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

true;
