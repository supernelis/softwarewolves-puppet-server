
node 'raspberrypi' {
	
	$serverdomain = "software.wolf"
		
	class{'ejabberd':
		domains => "pi.${serverdomain}",
	}

	class {'softwarewolves':
		install_dir => '/home/pi/app',
		example_js => 'raspberrypi.js',
	}
		
		
	include dns::server

  # Forward Zone
  dns::zone { $serverdomain:
    soa => "ns1.${serverdomain}",
    soa_email => "admin.${serverdomain}",
    nameservers => ["ns1.${serverdomain}"]
  }

  # Reverse Zone
  dns::zone { "${ipaddress}.IN-ADDR.ARPA":
    soa => "ns1.${serverdomain}",
    soa_email => "admin.${serverdomain}",    
    nameservers => ["ns1.${serverdomain}"]
  }


	dns::record::a {
	    'ns1':
    	  zone => $serverdomain,
	      data => [$ipaddress];
	}

  # CNAME Record:
  dns::record::cname {
  	'pi':
    	zone => $serverdomain,
	    data => "ns1.${serverdomain}";
    $hostname:
    	zone => $serverdomain,
	    data => "ns1.${serverdomain}";
  }
		
}

node 'awtest1.vm.bytemark.co.uk' {
	class{'ejabberd':
		domains => ["vm1.archiwise.com", "softwarewolves.org","awtest1.vm.bytemark.co.uk"],
	}

	file { '/etc/sww/':
		ensure => directory,
	}

	class {'softwarewolves':
		install_dir => '/etc/sww/',
		example_js => 'awtest1_example.js',
		require => File['/etc/sww/'],
	}

}