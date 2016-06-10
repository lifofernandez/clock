use feature 'say';
use Data::Dumper;

use Net::WebSocket::Server;
# https://metacpan.org/pod/Net::WebSocket::Server

# Server that sends the current time to all clients every second.
my $ws = Net::WebSocket::Server->new(
    listen => 8080,
    on_connect => sub {say 'Connection is established!';},
    tick_period => 1,
    on_tick => sub {
        my ($serv) = @_;
        $_->send_utf8(time) for $serv->connections;
    },

)->start;

# # Simple echo server for utf8 messages. (conecta pero pude recibir nada)
# Net::WebSocket::Server->new(
# 		listen => 8080,
# 		on_connect => sub {
# 				my ($serv, $conn) = @_;
# 				$conn->on(
# 						utf8 => sub {
# 								my ($conn, $msg) = @_;
# 								$conn->send_utf8($msg);
# 						},
# 				);

# 				say 'Connection is established!';
# 		},
# )->start;


# http://search.cpan.org/~topaz/Net-WebSocket-Server-0.001003/lib/Net/WebSocket/Server.pm


