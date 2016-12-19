use strict;
use warnings;

package Footprintless::Plugin::Atlassian::Confluence;

# ABSTRACT: A Footprintless plugin for working with Atlassian Confluence
# PODNAME: Footprintless::Plugin::Atlassian::Confluence

use parent qw(Footprintless::Plugin);

sub client {
    my ($self, $footprintless, $coordinate, @rest) = @_;

    return Footprintless::Plugin::Atlassian::Confluence::Client
        ->new($footprintless, $coordinate, @rest);
}

sub factory_methods {
    my ($self) = @_;
    return {
        client => sub {
            return $self->client(@_);
        },
    }
}

1;

__END__

=head1 DESCRIPTION

Provides a C<client> factory method to obtain a REST client for the 
L<Atlassian Confluence REST API|https://developer.atlassian.com/confdev/confluence-server-rest-api>.

=head1 ENTITIES

As with all plugins, this must be registered on the C<footprintless> entity.  

    plugins => [
        'Footprintless::Plugin::Atlassian::Confluence',
    ],

=method client($footprintless, $coordinate, %options)

Returns a new Atlassian Confluence REST client.

=for Pod::Coverage factory_methods

=head1 SEE ALSO

DBI
Footprintless
Footprintless::MixableBase
