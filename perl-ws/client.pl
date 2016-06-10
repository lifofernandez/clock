use feature 'say';
use Data::Dumper;

use AnyEvent::WebSocket::Client 0.12;

my $client = AnyEvent::WebSocket::Client->new;

$client->connect("ws://localhost:8080")->cb(sub {

	# make $connection an our variable rather than
	# my so that it will stick around.  Once the
	# connection falls out of scope any callbacks
	# tied to it will be destroyed.
	our $connection = eval { shift->recv };

	if($@) {
		# handle error...
		warn $@;
		return;
	}




	# send a message through the websocket...
	$connection->send('a message');

	$connection->send(
		AnyEvent::WebSocket::Message->new(body => "some message"),
	);

	# recieve message from the websocket...
	$connection->on(each_message => sub {
		# $connection is the same connection object
		# $message isa AnyEvent::WebSocket::Message
		my($connection, $message) = @_;
		print Dumper($message);
	});




	# handle a closed connection...
	$connection->on(finish => sub {
		# $connection is the same connection object
		my($connection) = @_;
	});

	# close the connection (either inside or
	# outside another callback)
	$connection->close;

	});