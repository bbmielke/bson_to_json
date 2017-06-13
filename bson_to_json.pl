#!/usr/bin/env morbo

use strict;
use warnings;
use Mojolicious::Lite;
use MIME::Base64;
use Data::Dumper;
use Mojo::JSON qw(decode_json);

post '/' => sub {
    my $c = shift;
    eval {
        my $input = $c->param('input');
        my $output = decode_base64($input);
        my $json = decode_json($output);
        $c->render(json => $json);
    };
    if($@) {
        $c->render(text => "Error: $@", status => 500);
    }
};


app->start;

