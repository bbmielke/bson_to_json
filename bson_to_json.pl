#!/usr/bin/env morbo

use strict;
use warnings;
use Mojolicious::Lite;
use MIME::Base64;
use Data::Dumper;


get '/' => { template => 'form', input => '', output => ''};

post '/' => sub {
    my $c = shift;
    my $input = $c->param('input');
    my $output = $c->param('output');

    my $message;
    eval {
        $output = decode_base64($input);
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
        <script>
          function set_text() {

            var output = `<%= $output %>`;
            var parser = new DOMParser;
            var dom = parser.parseFromString(output, 'text/html');
            var json = JSON.stringify(JSON.parse(dom.body.textContent), undefined, 2);
            document.getElementById('output').value = json;
          }
        </script>
        <body>
        <% if(my $message = flash 'message') { %>
          <p style="color:red;"><%= $message %></p>
        <% } %>
        %= form_for '/' => (method => 'post') => begin
          INPUT: <BR>
          %= text_area input => '', cols => 80, rows => 15, id => 'input',
          <BR>
          OUTPUT: <BR>
          %= text_area output => '', cols=>80, rows => 25, id => 'output',
          <BR>
          %= submit_button 'OK'
        % end
        <script>
          set_text();
        </script>
    </body>
  </html>