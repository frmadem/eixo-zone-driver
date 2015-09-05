

use strict;
use warnings;

use ExtUtils::testlib;

use Test::More tests => 2;
use POSIX;

BEGIN { use_ok('Eixo::Zone::Driver') };

SKIP: {

	skip "No root user" , 1 unless(getuid == 0);

	my $pid = Eixo::Zone::Driver->clone(sub {
	
		# we check that actually we are an "init" process
	
		if($$ == 1){
			exit 0;
		}
		else{
			exit 1;
		}
	
	}, &Eixo::Zone::Driver::CLONE_NEWPID | 17);
	
	
	waitpid($pid, 0);
	
	ok($? == 0 , "We forked a new init process");
}

done_testing();
