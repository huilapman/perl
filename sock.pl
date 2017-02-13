#!/usr/bin/perl

use strict;
use Unix::Syslog;
use File::Basename;
use IO::Socket::UNIX;


my $SOCK_PATH = "/tmp/unix-domain-socket-test.sock";

my $type = $ARGV[0];

if ($type eq "server") {
	# Server:
	print "Server...\n";
	unlink $SOCK_PATH if -e $SOCK_PATH;

	my $socket = IO::Socket::UNIX->new(
		Local  => $SOCK_PATH,
		Type   => SOCK_STREAM,
		Listen => SOMAXCONN,
	);

	die "Can't create socket: $!" unless $socket;

	#my $connection = $socket->accept();
	my $connection;
	while ($connection = $socket->accept()) {
		$connection->autoflush(1);

		while(<$connection>) {
			print $_;
			chomp;
		}

	}
	close($socket);

}

else {
	# Client:
	print "Client...\n";

	my $socket = IO::Socket::UNIX->new(
		Type => SOCK_STREAM,
		Peer => $SOCK_PATH,
	);

	die "Can't create socket: $!" unless $socket;

	my $line;
	while ($line = <>) {    # Get input from STDIN
		print $socket $line;
	}

}
