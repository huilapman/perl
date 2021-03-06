package ABC::PostServiceAPI;

$VERSION = v1.0;

use v5.10.0;
use strict;
use lib qw(/usr/local/ABC/lib/perl);
use URI;
use URI::Escape;
use LWP::UserAgent;
use HTTP::Request::Common qw{ POST };
use Encode;
use JSON;

sub PostService {
    my $service = shift;
    my $data  = shift;

    my $url = "https://postservice.abc.com/" . $service;
    print "========================================================\n";
    print " ABC PostService API\n";
    print "--------------------------------------------------------\n";
    print " Service Name: $service\n";
    print " URL: $url\n";
    print " Parameters:\n";
    for my $s (sort keys %$data) {
        print " \t$s => $$data{$s}\n";
    }
    print " Result:\n";
    my $ua = LWP::UserAgent->new();
    my $headers = HTTP::Headers->new(
            'Host' => 'postservice.abc.com',
            'Content-Type' => 'application/x-www-form-urlencoded',
            'Accept' => 'application/json'
            );

    my $req = HTTP::Request::Common::POST($url, $data);

    my $json = new JSON();
    $json = $json->sort_by(sub {
        return 1 if ($JSON::PP::a eq "version");
        return 1 if ($JSON::PP::b eq 'version');
        $JSON::PP::a cmp $JSON::PP::b;
        }
    );

    $ua->default_headers($headers);
    my $resp = $ua->request($req);
    if ($resp->is_success) {
        my $json_content = $resp->decoded_content;        
        Encode::_utf8_off($json_content);
        my $decoded = decode_json($json_content);
        print " " . $json->pretty->utf8->encode($decoded);
        print "========================================================\n\n\n";
        return $decoded;
    }
    else {
        print " HTTP POST error code: " . $resp->code . "\n";
        print " HTTP POST error content: " . $resp->decoded_content . "\n";
        print " HTTP POST error message: " . $resp->message . "\n";
        print "========================================================\n\n\n";
        return;
    }
}

sub GetMemberInfoByTelephone {
    my $data = shift;
    my $strCallUserCode  = exists($$data{strCallUserCode})? $$data{strCallUserCode} : '';
    my $strCallPassword  = exists($$data{strCallPassword})? $$data{strCallPassword} : '';
    my $strTelephone  = exists($$data{strTelephone})? $$data{strTelephone} : '';
    my $service = "GetMemberInfoByTelephone";
    my %param = (strCallUserCode => $strCallUserCode,
                strCallPassword => $strCallPassword,
                strTelephone => $strTelephone);
    return PostService($service, \%param);
}

sub SendVerifyCode {
    my $data = shift;
    my $strCallUserCode  = exists($$data{strCallUserCode})? $$data{strCallUserCode} : '';
    my $strCallPassword  = exists($$data{strCallPassword})? $$data{strCallPassword} : '';
    my $strTelephone  = exists($$data{strTelephone})? $$data{strTelephone} : '';
    my $service = "SendVerifyCode";
    my %param = (strCallUserCode => $strCallUserCode,
                strCallPassword => $strCallPassword,
                strTelephone => $strTelephone);
    return PostService($service, \%param);

=pod
    print "strCallUserCode: $strCallUserCode\n";
    print "strCallPassword: $strCallPassword\n";
    print "strTelepone: $strTelephone\n";
    my $json = '{
        "Return": {
            "Success": {
                "ReturnCode": "0",
                "Description": "0",
                "SecurityCode": "2129"
            }
        }
    }';
    my $decoded = decode_json($json);
    return $decoded;
=cut

}

=pod
#!/usr/bin/perl
use strict;
use lib qw(/usr/local/ABC/lib/perl);
use ABC::PostServiceAPI;
my $member = ABC::PostServiceAPI::GetMemberInfoByTelephone({strCallUserCode =>'username',
                                                strCallPassword => 'password',
                                                strTelephone => '+12345678'});
=cut
