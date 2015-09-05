use strict;
use warnings;

use Test::More;
use Eixo::Zone::Driver;

my $hostname = `hostname`;

chomp($hostname);


my $pid = Eixo::Zone::Driver->clone(

	sub {

		# new hostname

		my $new_hostname = "test." . int(rand(99999));

		`hostname $new_hostname`;

		my $t = `hostname`;

		chomp($t);

		if($new_hostname eq $t){
			
			exit 0;
		}
		else{
			exit 1;
		}

	},

	&Eixo::Zone::Driver::CLONE_NEWPID | 17 |

	&Eixo::Zone::Driver::CLONE_NEWUTS 

);

waitpid($pid, 0);

ok($? == 0, "Child changed its hostname");

my $test_hostname = `hostname`;

chomp($test_hostname);

ok($test_hostname eq $hostname, "Hostname has not been changed in parent namespace");


done_testing();
