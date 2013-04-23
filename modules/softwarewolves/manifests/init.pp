class softwarewolves(
  $install_dir =  undef,
  $example_js = undef
) {

	include 'nodejs'

	package{ 'git': 
		ensure => installed,
	}
	
	package {'libicu-dev':
		ensure => installed,
	}
	
	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
	
	git::clone { 'softwarewolves':
		source => 'git://git.cloudbees.com/archiwise/sww.git',
		localtree => "${install_dir}",
		require => Package['git'],
	}
	
	file{ "${install_dir}/runSww.sh":
		ensure => present,
		content => template('softwarewolves/runSww.sh'),
		mode    => '0755',
	}
	
	file{ "${install_dir}/swwrunner.sh":
		ensure => present,
		content => template('softwarewolves/swwrunner.sh'),
		mode    => '0755',
	}
	
	file{'/usr/local/bin/sww':
		ensure => link,
		target => "${install_dir}/runSww.sh",
		require => File["${install_dir}/runSww.sh"],
	}
	
	nodejs::npm{ "${install_dir}/softwarewolves/app/:softwarewolves":
		ensure => present,
		source => "${install_dir}/softwarewolves/app/",
		require => [Git::Clone['softwarewolves'], Package['nodejs']],
	}
}