use strict;
use warnings;

package Footprintless::Plugin::Atlassian::Confluence::ResponseParser;

use JSON;

sub new {
    return bless({}, shift)->_init(@_);
}

sub get_content {
    my ($self, $http_response) = @_;
    return $self->_parse_response($http_response);
}

sub _init {
    my ($self) = @_;
    return $self;
}

sub _parse_response {
    my ($self, $http_response) = @_;

    my %response = (
        code => $http_response->code(),
        message => $http_response->message(),
    );

    if ($http_response->is_success()) {
        $response{success} = 1;
        $response{content} = decode_json($http_response->decoded_content());
    }
    else{
        $response{success} = 0;
        $response{content} = $http_response->decoded_content();
    }

    return \%response;
}

1;
