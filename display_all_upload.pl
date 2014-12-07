#!/usr/bin/env perl
use v5.20;
use lib '.';
use Me::Schema;
use Dancer2;
use Imager;
use DDP;

my $schema = Me::Schema->connect('dbi:SQLite:Me.db');

get '/index' => sub {

    # retrieve the upload
    my @all_uploads = $schema->resultset('Upload')->all();

    @all_uploads =
      map { $_->{thumbnail_url} = uri_for( '/photo/thumbnail/' . $_->{id} ); $_ }
      grep { $_->{mime} =~m/image/ } 
      map { $_->{_column_data} } @all_uploads;

    template 'index.tt', { all_uploads => \@all_uploads };

};

get '/photo/thumbnail/:id' => sub {

    my $photo = $schema->resultset('Upload')->find( { id => params->{id} } );

    # why this not work?
    #    p $photo->extension;

    my $file = $photo->file;
    my ($ext) = mime->for_file( $photo->name )->extensions;

    my $data = $file->open('r') or die "Error: $!";

    my $img = Imager->new;
    $img->read( fh => $data ) or die $img->errstr;
    my $scaled = $img->scale( xpixels=> 200, ypixels => 200 );

    my $out;
    $scaled->write(
        type => $ext,
        data => \$out
    ) or die $scaled->errstr;
    content_type( $photo->mime );
    headers( "Content-Disposition" => "inline", "Content-Length" => -s $out );
    #binmode $out; # when use this?
    content($out);

};

dance;
