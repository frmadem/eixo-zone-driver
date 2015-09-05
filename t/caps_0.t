
use strict;
use warnings;

use Test::More;
use POSIX;

use_ok("Eixo::Zone::Driver");

SKIP:{

	skip "No root user", 1 unless(getuid == 0);  

	my %caps = Eixo::Zone::Driver->caps;
	
	# some root capabilites
	
	foreach(qw(
	
		cap_sys_admin
	
		cap_mac_admin
	
		cap_net_admin
	
		cap_sys_boot
	
	)){
	
		ok($caps{$_}, "$_ is present");
	
	}

}

done_testing();

