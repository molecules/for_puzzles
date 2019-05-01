#!/bin/env perl6
my $known-set = '/usr/share/dict/words'.IO.words.Set;

sub MAIN($word-in,$count=$word-in.chars(),:$mask) {
    my $last-index = $count - 1;
    my %found;
    my %known-letters;
    if $mask {
        for $mask.comb -> $letter {
            my $index = $++;
            next if $letter eq '_';
            %known-letters{$index} = $letter;
        }
    }

    for $word-in.comb.permutations -> $perm {
        my $word-putative = $perm[0..$last-index].join;


        if $word-putative (<) $known-set {
            %found{$word-putative} = 1 unless %found{$word-putative}:exists;
        }
    }

    if $mask {
        found_loop:
        for %found.keys -> $putative {
            for %known-letters.keys -> $index {
                next found_loop unless $putative.substr($index,1) eq %known-letters{$index};
            }
            say $putative;
        }
    }
    else {
        %found.keys.join("\n").say;
    }
}
