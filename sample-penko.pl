#!/usr/bin/perl
#####################################################################
# AUTHOR-------> L. Penko lpenko@gmx.de
# TITLE-------->
# CREATED------>
# VERSION------>
# COPYRIGHT----> Copyright © 2009 Ladislav Penko
# DESCRIPTION-->
# CHANGE LOG--->
#####################################################################
BEGIN {

      }
END {

    }
    
use strict;
use LWP::UserAgent;
use HTTP::Request::Common qw(POST GET);
#use URI::Escape;
my $product_id = 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01';
my %INST  = (          # URL/
              BIZ     => 'http://www.axiombox.com',
              PRIVATE => 'http://www.damog.net',
            );
my $UA = &createUserAgent(); 
my $BROWSER = `which firefox`;  #- Put you browser here 
chomp ($BROWSER);
foreach my $inst  (keys %INST) {
     my ($headers, $content) = &importDATA($UA, \$INST{$inst});
#      &writeLog("#-------------- BEGIN OF HEADERS FOR $inst --------------#");
#      &writeLog($$headers);
#      &writeLog("#-------------- END OF HEADERS FOR $inst --------------#");

     my $whois = `whois $1` if ($INST{$inst} =~ /^http:\/\/w{3}\.(.*)$/);
     my $registrant = $1 if ($whois =~ /Registrant:(.*\n.*)/);
     &writeLog("Registrant for $INST{$inst} -> $registrant");
     &parseContent($content); 
}       
#####################################################################
#####################################################################
#####################################################################
sub parseContent {
   my $cont = shift;
   if ($$cont =~ /src\=\"?(.*Photo-81-150x150\.\w{3})/) {
      &writeLog("And this is best moment of David on the work (see your $BROWSER) :-)");
      system("$BROWSER $1");
   }
}  
#####################################################################
#####################################################################
#####################################################################
sub createUserAgent {
my $ua  = new LWP::UserAgent;
   $ua->agent($product_id);
   $ua->from(undef);
   # $ua->proxy(undef);
   #$ua->proxy(['http','https'],'http://141.66.18.46:8888/'); # Please do not use proxy
   $ua->timeout(0);
   $ua->cookie_jar(undef);
   $ua->use_eval(0);
   $ua->parse_head(0);
   return \$ua;
}
#####################################################################
#####################################################################
#####################################################################
sub importDATA {
my ($ua, $url) = @_;
     my $response = $$ua->request (new HTTP::Request ('GET', $$url));
     my $content  = $response->content;
        if ($response->is_success || length($content) > 200) {
               return (\$response->headers_as_string, \$content);
	   } else {
                &error("LWP ERROR FOR: $$url");
                #- do something
	   }
           
}
#####################################################################
#####################################################################
#####################################################################
sub error {
   my ($str) = @_;
   print $str . "\n";  #- or/and handle errors
}
#####################################################################
#####################################################################
#####################################################################
sub writeLog {
   my ($str) = @_;
   print $str . "\n"; #- or/and write log file
}
