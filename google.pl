#!/usr/bin/perl

use v5.10.0;
use warnings;
use strict;

use CGI::Carp;
use URI;
use URI::Escape;
use CGI ':standard';

use LWP::UserAgent;
use JSON qw( decode_json );

use HTTP::Request::Common qw{ POST };

use Config::Simple;
use Data::Dumper;

my @params    = param();
my $q = CGI->new();
my $info;

my $googleConfig = new Config::Simple('google.ini');

if ($q->param('code')) {
	my $ua = LWP::UserAgent->new();  

	$ua->ssl_opts( verify_hostname => 0 );

	my $response = $ua->post($googleConfig->param('access_token_url'), {
		code=> $q->param('code'),
	 	client_id=> $googleConfig->param('client_id'),
	 	client_secret=>$googleConfig->param('client_secret'),
	 	redirect_uri=> $googleConfig->param('redirect_uri'),
	 	grant_type=> $googleConfig->param('grant_type')
	});

	
	my $decoded = decode_json($response->content());
		


	print "Content-type: text/html; charset=iso-8859-1\n\n";
	print "<html>";
	print "<body>";
	print "<h2>Response from access token request</h2>";
	print "<code>". $response->content() . "</code>";

	print "<h3>Extract JSON Content</h3>";
	print "<code>access_token=" . $decoded->{'access_token'} . "<br/>";
	print "expires_in=" . $decoded->{'expires_in'}  . "<br/>";
	print "token_type=" . $decoded->{'token_type'}  . "<br/>";
	print "id_token=" . $decoded->{'id_token'}  . "<br/></code>";



	my $url = $googleConfig->param('userinfo_url') . $decoded->{'access_token'};
	$info = $ua->get($url);
	my $infodecoded = decode_json($info->content());

	print "<h2>Response from info request</h2>";
	print "<code>". $info->content() . "</code>";
	print "</body>";
	print "</html>";

	# Redirect 
	print $q->header( -status=>'302',
			-location=>'http://localhost/cgi-bin/google.pl?email=' . $infodecoded->{'email'},
			-type  =>  'text/html');

}
else {
	if ($q->param('email')) {
		print "Content-type: text/html; charset=iso-8859-1\n\n";
		print "<html>";
		print "<body>";
		print "Google Email: " . $q->param('email');
		print "</body>";
		print "</html>";
	}
	else {
		print "Content-type: text/html; charset=iso-8859-1\n\n";
		print "<html>";
		print "<body>";

		my $url =   $googleConfig->param('oauth_url') .
					'client_id=' . $googleConfig->param('client_id') .
					'&redirect_uri=' . uri_escape($googleConfig->param('redirect_uri')) .
					'&response_type=' . $googleConfig->param('response_type') .
					'&scope=' . uri_escape($googleConfig->param('scope_userinfo_profile')) . '+' .
					          	uri_escape($googleConfig->param('scope_userinfo_email')) . '+' .
					          	uri_escape('https://www.googleapis.com/auth/contacts') . '+' .
					          	uri_escape('https://www.googleapis.com/auth/gmail.compose') .
					'&state=random';

		print "<a href='".$url."'>Login Google</a>";
		print "</body>";
		print "</html>";
	}
}

