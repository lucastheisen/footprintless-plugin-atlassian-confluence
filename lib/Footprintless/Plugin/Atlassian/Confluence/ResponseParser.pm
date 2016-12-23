use strict;
use warnings;

package Footprintless::Plugin::Atlassian::Confluence::ResponseParser;

# ABSTRACT: A response parser for the Atlassian Confluence REST API
# PODNAME: Footprintless::Plugin::Atlassian::Confluence::ResponseParser

use JSON;

sub new {
    return bless({}, shift)->_init(@_);
}

sub create_content {
    my ($self, $http_response) = @_;
    return $self->_parse_response($http_response);
}

sub delete_content {
    my ($self, $http_response) = @_;
    return $self->_parse_response($http_response);
}

sub get_content {
    my ($self, $http_response) = @_;
    return $self->_parse_response($http_response);
}

sub get_content_children {
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

    my $content = $http_response->decoded_content();
    if ($http_response->is_success()) {
        $response{success} = 1;
        $response{content} = $content ? decode_json($content) : '';
    }
    else{
        $response{success} = 0;
        $response{content} = $http_response->decoded_content();
    }

    return \%response;
}

sub update_content {
    my ($self, $http_response) = @_;
    return $self->_parse_response($http_response);
}

1;

__END__

=head1 SYNOPSIS

    my $response_parser = 
        Footprintless::Plugin::Atlassian::Confluence::ResponseParser
            ->new();

    # A parse a get content response
    my $response = $response_parser->get_content($http_response);
    die('failed') unless $response->{success};

=head1 DESCRIPTION

This is the default implementation of a response parser.  There is a parse 
method for corresponding to each build method in 
L<Footprintless::Plugin::Atlassian::Confluence::RequestBuilder>, and they
all parse http responses into a hasref of the form:

   my $response = {
       status => 0, # truthy if $http_response->is_success()
       code => 200, # $http_response->code()
       message => 'Success', # $http_response->message()
       content => {} # decode_json($http_response->decoded_content())
   };

=constructor new()

Constructs a new response parser.

=for Pod::Coverage create_content delete_content get_content get_content_children update_content 

=head1 SEE ALSO

Footprintless::Plugin::Atlassian::Confluence
Footprintless::Plugin::Atlassian::Confluence::Client
Footprintless::Plugin::Atlassian::Confluence::RequestBuilder
https://docs.atlassian.com/atlassian-confluence/REST/latest-server
