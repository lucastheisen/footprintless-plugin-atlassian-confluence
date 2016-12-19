use strict;
use warnings;

package Footprintless::Plugin::Atlassian::Confluence::RequestBuilder;

use HTTP::Request;
use JSON;
use Log::Any;

my $logger = Log::Any->get_logger();

sub new {
    return bless({}, shift)->_init(@_);
}

sub get_content {
    my ($self, %options) = @_;

    my $url;
    if ($options{id}) {
        $url = $self->_url("/rest/api/content/$options{id}",
            $self->_query_params(
                [
                    'status',
                    'version',
                    'expand',
                ],
                %options));
    }
    else {
        $url = $self->_url("/rest/api/content",
            $self->_query_params(
                [
                    'type',
                    'spaceKey',
                    'title',
                    'status',
                    'postingDay',
                    'expand',
                    'start',
                    'limit',
                ],
                %options));
    }

    return HTTP::Request->new('GET', $url);
}

sub _init {
    my ($self, $base_url) = @_;

    $self->{base_url} = $base_url;

    return $self;
}

sub _query_params {
    my ($self, $option_keys, %options) = @_;

    my %defined_options = ();
    foreach my $key (@$option_keys) {
        my $value = $options{$key};
        $defined_options{$key} = $value if (defined($value));
    }

    return %defined_options;
}

sub _url {
    my ($self, $path, %query_params) = @_;

    my @query_string = ();
    foreach my $key (sort(keys(%query_params))) {
        push(@query_string, (@query_string ? '&' : '?'));

        if (ref($query_params{$key}) eq 'ARRAY') {
            push(@query_string, 
                join('&', (map {"$key=$_"} @{$query_params{$key}})))
        }
        else {
            push(@query_string, "$key=$query_params{$key}");
        }
    }

    return "$self->{base_url}$path"
        . (@query_string ? join('', @query_string) : '');
}

1;
