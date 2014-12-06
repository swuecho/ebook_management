#!/usr/bin/env perl
use v5.20;
use DDP;
use Me::Schema;
use lib '.';

my $schema = Me::Schema->connect('dbi:SQLite:Me.db');

# retrieve the upload
my $upload = $schema->resultset('Upload')->find(1);

# get the relative path
say $upload->file->relative;

# get the absolute path
say $upload->file->absolute;

# get the base filename
say $upload->file->basename;

# get the mime type (image/png)
p $upload->mime;

# get the file extension
p $upload->extension;

__END__
# get a read filehandle
$upload->file->openr;

# get a write filehandle
$upload->file->openw;

# get an append filehandle
$upload->file->opena;)))
