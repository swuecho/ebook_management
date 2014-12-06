#!/usr/bin/env perl
use v5.20;
use lib '.';
use Me::Schema;
use MIME::Types;
use Path::Tiny;
use DDP;

my $schema = Me::Schema->connect('dbi:SQLite:Me.db');

# Add the file to the database and file system

my $iter = path("~/Pictures/Uploads")->iterator;

while ( my $path = $iter->() ) {
    say $path;
    my $name = $path->basename;
    my $mime =  MIME::Types->new->mimeTypeOf($name)
      or next;

    open( my $file, '<', $path ) or die $!;

    my $upload = $schema->resultset('Upload')->create(
        {
            name    => $name,
            file    => $file,
            mime    => $mime,
            caption => $name,
        }
    );
    p $upload;

}

