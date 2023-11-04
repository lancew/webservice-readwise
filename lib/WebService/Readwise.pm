use strict;
use warnings;

use v5.010;

package WebService::Readwise;

# ABSTRACT: Perl module to interact with Readwise.io API:w
use HTTP::Tiny;
use JSON::MaybeXS;

use Moo;
use namespace::clean;

has token => (
    is       => 'ro',
    required => 0,
    default  => sub { return $ENV{WEBSERVICE_READWISE_TOKEN} },
);

has base_url => (
    is      => 'ro',
    default => sub {'https://readwise.io/api/v2/'},
);

has http => (
    is      => 'ro',
    default => sub {
        return HTTP::Tiny->new;
    },
);

sub auth {
    my $self = shift;

    my $response = $self->http->request( 'GET', $self->base_url . 'auth/',
        { headers => { Authorization => "Token $self->{token}", }, } );

    return $response->{status};
}

sub export {
    my $self = shift;

    my $response = $self->http->request( 'GET', $self->base_url . 'export/',
        { headers => { Authorization => "Token $self->{token}", }, } );

    
    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json;  
}

sub highlights {
    my $self = shift;

    my $response = $self->http->request( 'GET', $self->base_url . 'highlights/',
        { headers => { Authorization => "Token $self->{token}", }, } );

    
    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json;
}


1;
