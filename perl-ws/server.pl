use feature 'say';
use Data::Dumper;

use Net::WebSocket::Server;
# https://metacpan.org/pod/Net::WebSocket::Server
# http://search.cpan.org/~topaz/Net-WebSocket-Server-0.001003/lib/Net/WebSocket/Server.pm


# Server that sends the current time to all clients every second.
my $ws = Net::WebSocket::Server->new(
		listen => 80,
		on_connect => sub {
			say 'Some connection...';

			my ($serv,$conn) = @_;
			$conn->on(
				utf8 => sub {
					# Send a msg
					$conn->send_utf8('Hi, im the Server!');
					my ($conn, $msg) = @_;
					say 'Got new message: '.$msg;
				},
			);
		},

		tick_period => 0.5,
		on_tick => sub {
			my ($serv) = @_;
			$_->send_utf8(time) for $serv->connections;
			# say 'ping...';
		},


)->start;



