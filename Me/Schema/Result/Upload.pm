use utf8;
package Me::Schema::Result::Upload;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Me::Schema::Result::Upload

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<upload>

=cut

__PACKAGE__->table("upload");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 file

  data_type: 'text'
  is_nullable: 0

=head2 mime

  data_type: 'text'
  is_nullable: 0

=head2 ts

  data_type: 'datetime'
  is_nullable: 0

=head2 caption

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "file",
  { data_type => "text", is_nullable => 0 },
  "mime",
  { data_type => "text", is_nullable => 0 },
  "ts",
  { data_type => "datetime", is_nullable => 0 },
  "caption",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-12-06 13:17:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lY+GFHe49Bt2I6u5Lj28wg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use File::MimeInfo 'extensions';

__PACKAGE__->load_components("InflateColumn::FS");
__PACKAGE__->add_columns(
			 "file",
			 {
			  data_type      => 'TEXT',
			  is_fs_column   => 1,
			  fs_column_path => 'uploads',
			 }
			);

sub extension {
  my ($self) = @_;
  [ extensions($self->mime) ]->[0];
 }
1;
