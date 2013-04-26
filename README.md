softwarewolves-puppet-server
============================

The configuration to setup the softwarewolves server on a debian like system.

This project relies on several existing git modules available on github, who are added as git submodules.

To clone, use:
git clone --recursive https://github.com/supernelis/softwarewolves-puppet-server.git

Usage:
1. Make a node configuration for your node in the manifest/nodes.pp file

1. Upload the everything to the server. A basic upload script is provided. 

	./upload example.com username '/home/username/app/softwarewolves-puppet-server'
	
1. Login to the server and run puppet

	./runPuppet.sh
