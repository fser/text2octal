#!/usr/bin/env perl

use strict;

# 1 <=> execute
# 2 <=> write
# 4 <=> read
# 1000 <=> sticky
# 2000 <=> setgid
# 4000 <=> setuid

sub subcalcul
{
    my $rights = shift;
    my $octal = 0;

    $octal += 1 if $rights->{'x'};
    $octal += 2 if $rights->{'w'};
    $octal += 4 if $rights->{'r'};
    
    $octal;
}

sub block2octal
{
    my $right = shift;
    my $octal = 0;

    $octal += 4000 if ($right->{'setuid'});
    $octal += 2000 if ($right->{'setgid'});
    $octal += 1000 if ($right->{'sticky'});

    $octal += subcalcul($right->{'owner'}) * 100;
    $octal += subcalcul($right->{'group'}) * 10;
    $octal += subcalcul($right->{'other'});

    $octal;
}

sub block2struct
{
    my ($r,$w,$x) = @_;
    my $res = { 'flag' => ($x eq 's' || $x eq 'S' || $x eq 't' || $x eq 'T') ? 1 : 0,
                'perm' => { 'r' => $r eq 'r' ? 1 : 0,
                            'w' => $w eq 'w' ? 1 : 0,
                            'x' => ($x eq 'x' || $x eq 's' || $x eq 't') ? 1 : 0
                }
    };
}

sub text2octal
{
    my $text = shift;
    my $octal= 0;

    my $rights = {'sticky' => 0,
                  'setuid' => 0,
                  'setgid' => 0,
                  'owner' => { 'r' => 0,
                               'w' => 0,
                               'x' => 0
                  },
                  'group' => { 'r' => 0,
                               'w' => 0,
                               'x' => 0
                  },
                  'other' => { 'r' => 0,
                               'w' => 0,
                               'x' => 0
                  }
    };
    
    $text = substr($text, 1, 9) if (length($text)==10);
    
    my $r = block2struct(split //, substr($text, 0, 3));
    $rights->{'setuid'} = 1 if ($r->{'flag'}==1);
    $rights->{'owner'} = $r->{'perm'};
    
    $r = block2struct(split //, substr($text, 3, 3));
    $rights->{'setgid'} = 1 if ($r->{'flag'}==1);
    $rights->{'group'} = $r->{'perm'};

    $r = block2struct(split //, substr($text, 6, 3));
    $rights->{'sticky'} = 1 if ($r->{'flag'}==1);
    $rights->{'other'} = $r->{'perm'};

    block2octal $rights;
}



die('usage: text-based-right [ text-based-right, ... ]') unless scalar(@ARGV)>0;
my @output = ();

push(@output, {'txt' => $_, 'oct' => text2octal($_)}) foreach (@ARGV);

foreach (@output)
{
    printf("%10s %4d\n", $_->{'txt'}, $_->{'oct'});
}
