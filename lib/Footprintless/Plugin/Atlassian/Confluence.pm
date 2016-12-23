use strict;
use warnings;

package Footprintless::Plugin::Atlassian::Confluence;

# ABSTRACT: A Footprintless plugin for working with Atlassian Confluence
# PODNAME: Footprintless::Plugin::Atlassian::Confluence

use parent qw(Footprintless::Plugin);

sub _client {
    my ($self, $footprintless, $coordinate, %options) = @_;

    $options{request_builder_module} =
        $self->{config}{request_builder_module}
        if (!$options{request_builder_module} 
            && $self->{config}{request_builder_module});
    $options{response_parser_module} =
        $self->{config}{response_parser_module}
        if (!$options{response_parser_module} 
            && $self->{config}{response_parser_module});

    require Footprintless::Plugin::Atlassian::Confluence::Client;
    return Footprintless::Plugin::Atlassian::Confluence::Client
        ->new($footprintless, $coordinate, %options);
}

sub factory_methods {
    my ($self) = @_;
    return {
        confluence_client => sub {
            return $self->_client(@_);
        },
    }
}

1;

__END__

=head1 DESCRIPTION

Provides a C<confluence_client> factory method to obtain a REST client for the 
L<Atlassian Confluence REST API|https://developer.atlassian.com/confdev/confluence-server-rest-api>.

=head1 ENTITIES

As with all plugins, this must be registered on the C<footprintless> entity.  

    plugins => [
        'Footprintless::Plugin::Atlassian::Confluence',
    ],

You may provide custom implementation of the request builder or response
parser as well:

    plugins => [
        'Footprintless::Plugin::Atlassian::Confluence',
    ],
    'Footprintless::Plugin::Atlassian::Confluence' => {
        request_builder => 'My::Confluence::RequestBuilder',
        response_parser => 'My::Confluence::ResponseParser',
    }

=for Pod::Coverage factory_methods

=head1 SEE ALSO

Footprintless
Footprintless::MixableBase
Footprintless::Plugin::Atlassian::Confluence
Footprintless::Plugin::Atlassian::Confluence::Client
Footprintless::Plugin::Atlassian::Confluence::RequestBuilder
Footprintless::Plugin::Atlassian::Confluence::ResponseParser
https://docs.atlassian.com/atlassian-confluence/REST/latest-server
