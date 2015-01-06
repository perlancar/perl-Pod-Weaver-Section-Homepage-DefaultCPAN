package Pod::Weaver::Section::Homepage::DefaultCPAN;

use 5.010001;
use Moose;
#use Text::Wrap ();
with 'Pod::Weaver::Role::Section';

#use Log::Any '$log';

use Moose::Autobox;

has text => (
    is => 'rw',
    isa => 'Str',
    default => q{Please visit the project's homepage at L<%s>.},
);

# VERSION

sub weave_section {
  my ($self, $document, $input) = @_;

  my $name = $input->{zilla}->name;
  my $homepage = $input->{distmeta}{resources}{homepage} //
      "https://metacpan.org/release/$name";

  my $text = sprintf $self->text, $homepage;

  #$text = Text::Wrap::wrap(q{}, q{}, $text);

  $document->children->push(
    Pod::Elemental::Element::Nested->new({
      command  => 'head1',
      content  => 'HOMEPAGE',
      children => [
        Pod::Elemental::Element::Pod5::Ordinary->new({ content => $text }),
      ],
    }),
  );
}

no Moose;
1;
# ABSTRACT: Add a HOMEPAGE section (homepage defaults to MetaCPAN release page)

=for Pod::Coverage weave_section

=head1 SYNOPSIS

In your C<weaver.ini>:

 [Homepage::DefaultCPAN]

To specify homepage other than C<https://metacpan.org/release/NAME>, in
dist.ini:

 [MetaResources]
 homepage=http://example.com/


=head1 DESCRIPTION

This section plugin adds a HOMEPAGE section using C<homepage> metadata, or
MetaCPAN release page if C<homepage> is not specified.


=head1 ATTRIBUTES

=head2 text

The text that is added. C<%s> is replaced by the homepage url.

Default: C<Please visit the project's homepage at LE<lt>%sE<gt>.>


=head1 SEE ALSO

L<Pod::Weaver::Section::Availability>

=cut
