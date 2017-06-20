#!/usr/bin/env morbo

use strict;
use warnings;
use Mojolicious::Lite;
use MIME::Base64;
use Data::Dumper;
use JSON::PP;


get '/' => { template => 'form', input => '', output => ''};

post '/' => sub {
    my $c = shift;
    my $input = $c->param('input');
    my $output = $c->param('output');

    my $message;
    eval {
        my $prettyfier = JSON::PP->new->ascii->pretty->allow_nonref;
        $output = $prettyfier->encode(decode_json(decode_base64($input)));
    };
    if($@) {
        $message = "Error: $@";
    }
    $c->render(template => 'form', input => $input, output => $output, message => $message);
};


app->start;

__DATA__

@@ form.html.ep
    <!DOCTYPE html>
        <html>
        <body>
        <% if(my $message = flash 'message') { %>
          <p style="color:red;"><%= $message %></p>
        <% } %>
        %= form_for '/' => (method => 'post') => begin
          INPUT: <BR>
          %= text_area input => '', cols => 80, rows => 15, id => 'input',
          <BR>
          OUTPUT: <BR>
          <textarea cols="80" rows="25" id="output">
%= stash 'output';
          </textarea>
          <BR>
          %= submit_button 'OK'
        % end
    </body>
  </html>