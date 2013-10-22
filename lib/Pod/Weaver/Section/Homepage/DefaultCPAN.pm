package Pod::Weaver::Section::Homepage::DefaultCPAN;

use 5.010001;
use Moose;
#use Text::Wrap ();
with 'Pod::Weaver::Role::Section';

#use Log::Any '$log';

use Moose::Autobox;

# VERSION

sub weave_section {
  my ($self, $document, $input) = @_;

  my $name = $input->{zilla}->name;
  my $homepage = $input->{distmeta}{resources}{homepage} //
      "https://metacpan.org/release/$name";

  my $text = "Please visit the project's homepage at L<$homepage>.";

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
# ABSTRACT: Add a HOMEPAGE section

=for Pod::Coverage weave_section

=head1 SYNOPSIS

In your C<weaver.ini>:

 [Homepage::DefaultCPAN]

To specify a bugtracker other than C<https://metacpan.org/release/NAME>, in
dist.ini:

 [MetaResources]
 homepage=http://example.com/


=head1 DESCRIPTION

This section plugin adds a HOMEPAGE section.


=head1 SEE ALSO

L<Pod::Weaver::Section::Availability>

=cut
