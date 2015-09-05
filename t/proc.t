use strict;
use warnings;

use Test::More;
use Eixo::Zone::Driver;

use POSIX;

SKIP:{

	skip "No root user" , 1 unless(getuid == 0);

	my $pid = Eixo::Zone::Driver->clone(
	
		sub {
	
			print `mount -t proc proc /proc`;
	
			opendir(D, '/proc');
	
			my @ps = grep { $_ =~ /^\d+$/} readdir(D);
	
			closedir(D);
	
			exit 1 unless(@ps == 1);
	
			exit 0;
	
		},
	
		&Eixo::Zone::Driver::CLONE_NEWPID | 17 |
	
		&Eixo::Zone::Driver::CLONE_NEWNS
	
	);
	
	waitpid($pid, 0);
	
	ok($? == 0, "Child finished ok");

}

done_testing();
