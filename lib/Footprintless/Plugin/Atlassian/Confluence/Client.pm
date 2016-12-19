use strict;
use warnings;

package Footprintless::Plugin::Atlassian::Confluence::Client;

use parent qw(Footprintless::MixableBase);

use Footprintless::Mixins qw(
    _sub_entity
);
use Footprintless::Util qw(
    dynamic_module_new
);

sub _init {
    my ($self, %options) = @_;

    $self->{username} = $self->_sub_entity('automation.username', 1);
    $self->{password} = $self->_sub_entity('automation.username', 1);
    $self->{agent} = $options{agent} || $self->{footprintless}->agent();
    $self->{request_builder} = dynamic_module_new(
        ($options{request_builder} || 
           'Footprintless::Plugin::Atlassian::Confluence::RequestBuilder'),
        $self->_sub_entity('web', 1));
    $self->{response_parser} = dynamic_module_new(
        ($options{response_parser} || 
           'Footprintless::Plugin::Atlassian::Confluence::ResponseParser'));

    return $self;
}

sub _send_request {
    my ($self, $request) = @_;
    return $self->{agent}->request($request);
}

1;
