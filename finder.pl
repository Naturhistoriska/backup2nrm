#! /usr/bin/env perl

#===============================================================================
=pod

=head1

         FILE: finder.pl

        USAGE: ./finder.pl

  DESCRIPTION:  

      OPTIONS: ---

 REQUIREMENTS: ---

         BUGS: ---

        NOTES: ---

       AUTHOR: Johan Nylander (nylander) <johan.nylander@nbis.se>

      COMPANY: NBIS/NRM

      VERSION: 0.1

      CREATED: 2018-05-23 22:05

     REVISION: ---

=cut

#===============================================================================

use strict;
use warnings;
use Data::Dumper;

my $findinboxes = '/proj/sllstore2017093';
my $inboxes = q{}; # Array ref
#my @inboxes = ();

sub find_inboxes {
    ## Arg is path to start searching: '/proj/sllstore2017093/'
    ## Need a trailing slash.
    ## Note redirection of all errs to /dev/null
    ## Reads an arbitrary number of lines
    my ($searchpath) = (@_);
    if ($searchpath !~ /\/$/) {
        $searchpath = $searchpath . '/';
    }
    print Dumper ($searchpath);
    open FIND, "find $searchpath -maxdepth 4 -type d -name MASTER_INBOX 2>/dev/null |";
    read FIND, my $find_output, 99999;
    my @boxes = split(/\n/, $find_output);
    return \@boxes;
}

if ($findinboxes) {
    if (! -d $findinboxes) {
        die "Error: Can not locate directory $findinboxes.\nNeed to provide correct path to where to start looking for INBOXes.\n";
    }
    else {
        #if (! $findinboxes =~ /\/$/) {
        #    $findinboxes = $findinboxes . '/';
        #}
        $inboxes = find_inboxes($findinboxes);
    }
}

print Dumper($inboxes);

