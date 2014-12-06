#!/usr/bin/env perl
use v5.20;
use lib '.';
use Me::Schema;
use Dancer2;

my $schema = Me::Schema->connect('dbi:SQLite:Me.db');


get '/*' => sub {
# retrieve the upload
my $upload = $schema->resultset('Upload')->find(1);

# get the absolute path
say $upload->file->absolute;
say $upload->ts;
say $upload->name;
return $upload->name;
};

dance;
