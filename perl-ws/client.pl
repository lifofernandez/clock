use feature 'say';
use Data::Dumper;

use AnyEvent::WebSocket::Client 0.12;

my $client = AnyEvent::WebSocket::Client->new;

$client->connect("ws://localhost:80")->cb(sub {

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
	$connection->send('Hi, im a client!');

	# recieve messages from the websocket...
	$connection->on(each_message => sub {
		# $connection is the same connection object
		# $message isa AnyEvent::WebSocket::Message
		my($connection, $message) = @_;
		say 'Got new message: '.$message->body;
	});




	# handle a closed connection...
	$connection->on(finish => sub {
		# $connection is the same connection object
		my($connection) = @_;
		say 'Connection terminated!'
	});

	# uncomment to Terminate Connection!
	# close the connection (either inside or outside another callback)
	# $connection->close;

	});

# uncomment to enter the event loop before exiting.
# Note that calling recv on a condition variable before
# it has been triggered does not work on all event loops
AnyEvent->condvar->recv;