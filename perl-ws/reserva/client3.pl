use IO::Socket;
my $sock = IO::Socket::INET->new('localhost:8080');
$sock->read($data, 1024) until $sock->atmark;
use Data::Dumper;
print Dumper($sock);
 #