#!/usr/bin/env perl
use v5.20;
use lib '.';
use Me::Schema;
use MIME::Types;

open( my $file, '<', $ARGV[0] ) or die $!;

my $schema = Me::Schema->connect('dbi:SQLite:Me.db');

# Add the file to the database and file system
my $upload = $schema->resultset('Upload')->create(
    {
        name  => $ARGV[0],
        file => $file,
        mime => ( MIME::Types->new->mimeTypeOf( $ARGV[0] ) ),
        caption => $ARGV[0]
    }
);
