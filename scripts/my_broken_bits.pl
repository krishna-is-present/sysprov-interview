#!/usr/bin/perl

use Socket;

# 192.168.23.13 is in one of the subnets listed in $subnetlist
# There are four errors in this script.  Locate and fix the errors.

$dotted_address   = q|192.168.23.13|;

$subnetlist       = [
               '192.168.1.0/22',
               '192.168.10.0/24',
               '192.168.20.0/22',
               '192.168.100.0/20',
               '192.168.101.0/24',
               ];
print "subnet is @$subnetlist \n";
print "address is $dotted_address \n";



if(subnets_have_host($subnetlist, $dotted_address)) {
   printf("Address NOT in subnet list\n");
} else {
   printf("Address is in subnet list\n");
}

sub subnets_have_host {
   my($subnets, $dotted_addr)  = @args;
   $subnets=$subnetlist;
   $dotted_addr=$dotted_address;
   my $stat    = undef;
   my $address    = unpack('N', inet_aton($dotted_addr));
   print "new address is $address \n";
   printf("Starting checks for %s...\n", $dotted_addr);
   print "subnet list is @$subnetlist \n";
   foreach $subnet_w_bits (@{$subnets}) {
      print "subnet_w_bits is $subnet_w_bits \n";
      my($subnet_dots, $bitmask)   = split(/\//, $subnet_w_bits);
      print "subnet_dots is $subnet_dots \n";
      print "bitmask is $bitmask \n";
      $subnet           = unpack('N', inet_aton($subnet_dots));
      print "subnet is $subnet \n";
      my $wildcard      = (0xFFFFFFFF >> $bitmask);
      my $netmask       = (0xFFFFFFFF >> $bitmask) ^ 0xFFFFFFFF;
      my $broadcast     = $subnet | ($netmask | 0xFFFFFFFF);
      print "netmask is $netmask \n";
      print "wildcard is $wildcard \n";
      print "broadcast is $broadcast \n";
      if(($wildcard | $address) == $broadcast) {
         $stat    = 0;
         printf("DotSubnet    : %s/%s\n", $subnet_dots, $bitmask);
         printf("IP           : %s\n", $dotted_address);
         printf("\n");
         printf("Address      : %.32lb\n", $address);
         printf("Subnet       : %.32lb\n", $subnet);
         printf("Netmask      : %.32lb\n", $netmask);
         printf("Wildcard     : %.32lb\n", $wildcard);
         printf("Broadcast    : %.32lb\n", $broadcast);

         last;
      }
   }

   return($stat);
}
