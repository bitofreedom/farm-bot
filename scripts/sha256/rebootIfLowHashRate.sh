#!/usr/bin/php
<?php

// miner ip and port, and the threshold you want to reboot it if it goes under:
// $IP="192.168.2.101";
$PORT="4028";
$THRESHOLD=8000.0;

// this works on a S9 12.93 circa Feb 2017. you shouldn't have to edit anything
// below this line unless the api on yours has different commands / output.  If
// it does let me know and I'll be happy to tweak it.

$FILE_PATH=$argv[1];

if ($file = fopen("$FILE_PATH", "r")) {
    while(!feof($file)) {
        $line = fgets($file);
		
		// create a socket
		$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
		if ($socket === false) {
		    echo "socket_create() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
		}

		// connect to antminer api
		$result = socket_connect($socket, $line, $PORT);
		if ($result === false) {
		    echo "socket_connect() failed.\nReason: ($result) " . socket_strerror(socket_last_error($socket)) . "\n";
		}

		// send a 'summary' command to antminer
		$in = '{"command":"summary"}';
		$out = '';
		socket_write($socket, $in, strlen($in));

		// read output from antminer
		$output="";
		while ($out = socket_read($socket, 2048)) {
		    $output=$output.$out;
		}
		socket_close($socket);

		// parse hashrate
		$hashrate=substr($output,strpos($output,"GHS 5s")+9);
		$hashrate=floatval(substr($hashrate,0, strpos($hashrate,"\"")));
		print date("Y-m-d H:i")." - ".$hashrate." - ";

		// compare hashrate to threshold and reboot if it's too low
		if ( $hashrate < $THRESHOLD ) {
		  print "ERROR - LOW HASHRATE.  Rebooting Antminer.\n";
		  system("ssh -i /root/.ssh/id_rsa root@".$line." /sbin/reboot");
		  print "\n";
		} else {
		  print "Ok.\n";
		}
    }
    fclose($file);
}

?>
