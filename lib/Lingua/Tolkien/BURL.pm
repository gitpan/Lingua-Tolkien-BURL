package Lingua::Tolkien::BURL;

use 5.008003;
use Filter::Simple;
use strict;
use warnings;

require Exporter;

our @ISA       = qw(Exporter);
our @EXPORT_OK = qw();
our @EXPORT    = qw();

our $VERSION = '0.50';


# First, a happy greeting.
# Literally, "Drat your garbage orders, dung-rabble racket-maker!"
print "Garn lab bûnur srinukh, bag dalug-hai shâtaza!\n";

my $c   = '#';

FILTER #_ONLY code => sub
{   
   s/!/;/g;                             # translate all ! to ; (!!)

   s/û/uu/g;
   s/â/aa/g;
   
   s/\b(\w+)at\b/\@$1/g;                # array context
   s/\b(\w+)uk\b/\$$1/g;                # scalar context
   s/\b(\w+)ul\b/\%$1/g;                # hash context

   s/\bu\b/$c/g;                        # comment char
   s/\bo\b/,/g;                         # comma
   s/adh/} else {/g;                    # else
   s/\bai;/print STDERR/g;              # print STDERR
   s/ash/1/g;                           # 1
   s/asha/scalar/g;                     # scalar
   s/baduzg/open/g;                     # open
   s/bal/2/g;                           # 2
   s/bhaduur/chdir/g;                   # chdir
   s/buurz\s*(.*?)--/sleep($1); /g;     # sleep
   s/dab/my/g;                          # my
   s/\bda\b/\$_/g;                      # $_
   s/dho/8/g;                           # 8
   s/dig/4/g;                           # 4
   s/daur/\@/g;                         # at sign
   s/fauth/close/g;                     # close
   s/fulg\s*(.*?)--/while ($1) { /g;    # while
   s/gaakh\s*(.*?)--/if ($1) { /g;      # if
   s/gakh/3/g;                          # 3
   s/ghaash\s*(.*?)--/} elsif ($1) { /g;# elsif
   s/gimb\s*(.*?);/\{$1\}/g;            # hash indexing
   s/krak/5/g;                          # 5
   s/^krimp/=pod/g;                     # =pod
   s/krith/9/g;                         # 9
   s/^krum/=cut/g;                      # =cut
   s/kud/6/g;                           # 6
   s/kuu\s*(.*?)--/until ($1) { /g;     # until
   s/lab\s*(.*?);/[$1]/g;               # array indexing
   s/mad/die/g;                         # die
   s/madurz/kill/g;                     # kill
   s/magog\s*(.*?)--/print "$1\n";/g;   # print rest of line
   s/mogda/print;/g;                    # print;
   s/mog/print/g;                       # print
   s/naar/0/g;                          # 0
   s/nar|sha/};/g;                      # }
   s/prakhug/pop/g;                     # pop
   s/pushdug/push/g;                    # push
   s/raakha/split ' '/g;                # split ' '
   s/raakh/split/g;                     # split
   s/shum\s*(.*?)--/($1)/g;             # list constructor
   s/skai/;/g;                          # ;   
   s/snaga\s*(.*?)--/sub $1 { /g;       # sub
   s/thag/10/g;                         # 10
   s/thrak/join/g;                      # join
   s/udu/7/g;                           # 7
   s/lug/for(;;) {/g;                   # forever()
   s/uur\s*(.*?)--/for ($1) { /g;       # for
   s/zabruuz/print "\n";/g;             # newline
};


1 ;

__END__

=head1 NAME

  Lingua::Tolkien::BURL -- An Orkish scripting language.
  
=head1 SYNOPSIS

   use Lingua::Tolkien::BURL;
   
   u   BURL uses the letter 'u' to denote comments.
   u   In Orkish, 'u' means 'to, towards', and thus
   u   probably implies something like 'ad hoc' for 
   u   BURL programmers, further strengthening the
   u   belief that Orcs make poor code documenters.
  
   magog This is only a test. --
   
   dab bat = shum 'a' o 'b' o 'e' -- skai 
   
   uur bat -- mogda nar!
   
   zabruuz gaakh 1 == 1 -- mog "ok" skai sha!
   
   dab myhashul!
   
   myhashuk gimb member! = 5 skai!
   
   mog myhashuk gimb member!!

   dab fugat = raakha o "a b c d e" skai

   uur fugat -- 
      mog da skai zabruuz! nar!

  
=head1 DESCRIPTION

BURL is based on perl -- in fact, it is a subset of perl, written with 
the Orc-programmer in mind. As such, control structures use Orkish or 
Black Speech instead of English; also, the rules of the scripting language 
are more constrained than perl. In fact, they are constrained to a format 
which is quite amenable to line-substitution translation into perl, 
strangely enough.

The most striking feature of BURL (aside from its use of Black Speech, of 
course) is the lopsided block delimiters nar! and sha!, which only terminate 
a block. BURL assumes that control structures begin all blocks (horrors!).

=head1 OVERVIEW

Here are the basic rules for BURL:

1. Exclamation points separate statements.  
   So does the keyword 'skai'.  
   
2. The double-dash separates control expressions from control blocks.

3. Blocks end with nar! or sha! (They are interchangeable).

4. û and uu are interchangeable, as are â and aa.

5. Commands may not always require whitespace separation.
   For example, the Perl snippet
      foreach (@bat) { print; }
   Can be written in BURL as:
      uur daurbat -- mogsha skai!

6. Scalar context is denoted by the suffix 'uk'.
   Array context is denoted by the suffix 'at'.
   Hash context is denoted by the suffix 'ul'.
   
   So, this declares a hashtable named "myhash":
   
      dab myhashul!
   
   And this accesses members of myhash:
   
      myhashuk{member};
      
   But there is also special way of indexing hashes:
   
      myhashuk gimb member!
   
You get the idea.  Here is a (mostly) alphabetic index of the elements of BURL:

=over 3

=item ! ";"

=item u (Comment)

=item o (Comma)

=item at (Array context)

When found as a suffix, it serves as the array context (@).
For example, 'bat' would be translated to '@b'.

=item uk (Scalar context)

When found as a suffix, it serves as the scalar context ($).
For example, 'buk' would be translated to '$b'.

=item ul (Hash context)

When found as a suffix, it serves as the hash context (%).
For example, 'bul' would be translated to '%b'.

=item adh  "} else {".

=item ai! "print STDERR".

=item ash "1"

=item asha "scalar"

=item baduzg "open"

=item bal "2"

=item bhaduur "chdir"

=item buurz expr -- "sleep(expr); "

=item \bda\b  "$_"

=item dab "my"

=item dho "8"

=item dig "4"

=item daur "@"

=item fauth "close"

=item fulg expr -- "while (expr) {"

=item gaakh expr -- "if (expr) {"

=item gakh "3"

=item ghaash expr -- "} elsif (expr) {"

=item gimb expr! "{expr}"

=item krak "5"

=item /^krimp/ "=pod"

=item krith "9"

=item /^krum/ "=cut"

=item kud "6"

=item kuu expr -- "until (expr) {"

=item lab expr! "[expr]"

=item mad "die"

=item madurz "kill"

=item magog expr -- "print "expr";"

=item mog "print"

"mog" works best with single variables.  For printing messages, 
use "magog".

=item mogda "print;"

=item naar "0"

=item nar "};"

=item prakhug "pop"

=item pushdug "push"

=item raakh "split"

=item raakha "split ' '"

=item sha "};"

=item shum expr -- "(expr)"  (List constructor)

=item skai ";"

=item snaga name -- "sub name {"

=item thag "10"

=item thrak "join"

=item udu "7"

=item lug "for(;;) {"

=item uur expr -- "for (expr) {"

=item zabruuz "print "\n";"

=back

=head1 CAVEAT

Since the BURL filter relies upon willy-nilly string substitution,
there may well be flaws in the current implementation...

=head1 AUTHOR

  Robert Eaglestone

=head1 COPYRIGHT

  Copyright 2004, Robert Eaglestone

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AVAILABILITY

The latest version of this library is likely to be available from CPAN.

=cut
