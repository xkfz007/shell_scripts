#!/usr/bin/perl -w
# by Loren Merritt, 2007-09-09

use Getopt::Long;

my $usage =
"vbv.pl [options] infile\n".
"  --fps      (required for textfile inputs)\n".
"  --bitrate  (kbit/s)\n".
"  --bufsize  (kbit)\n".
"  --init     (kbit)\n".
"  --log      (filename)\n".
"Analyzes video streams for VBV compliancy.\n".
"If you specify bitrate, bufsize, and init, it will check whether the stream is compliant.\n".
"If you specify just bitrate or bufsize, it will solve for the remaining values.\n".
"Infile can be:\n".
"  a text file containing frame sizes in bytes, 1 per line\n".
"  a text file containing the output of `x264 -v`\n".
"  matroska (only the first track is analyzed)\n";

GetOptions("fps=f" => \$fps,
           "bitrate=f" => \$bitrate,
           "bufsize=f" => \$bufsize,
           "init=f" => \$init,
           "log=s" => \$log);

if(defined($bitrate)) { $bitrate *= 1000 }
if(defined($bufsize)) { $bufsize *= 1000 }
if(defined($init)) { $init *= 1000 }

if(@ARGV and $ARGV[0] =~ /\.mkv$/i) {
    open(FH, "-|", "mkvinfo", "-v", $ARGV[0]) or die "can't exec `mkvinfo -v $ARGV[0]`\n";
    if(!$fps) {
        while(<FH>) {
            if(/Default duration: \d+\.\d+ms \((\d+\.\d+) fps for a video track\)/) {
                $fps = $1;
                last;
            }
        }
        $fps or die "can't find fps\n";
    }
    while(<FH>) {
        if(/\+ (Simple)?Block \((discardable, )?track number 1, 1 frame\(s\), timecode/) {
            <FH> =~ /\+ Frame with size (\d+)$/m or die "can't parse mkvinfo output:\n$_\n";
            push @sizes, $1;
        }
    }
    close FH;
} else {
    $fps or die $usage;
    while(<>) {
        my ($plain, $v);
        if(!$v && /^\d+$/) {
            push @sizes, $_;
            $plain = 1;
        } elsif($plain && /\S/) {
            die "can't parse line $_\n";
        } elsif(/x264 \[debug\]: frame.*size=(\d+) *bytes/) {
            push @sizes, $1;
            $v = 1;
        }
    }
}

@sizes or die $usage;

if(defined($log)) {
    open $logfh, ">", $log or die "$!\n";
    print $logfh "$_\n" for @sizes;
    close $logfh;
}

sub check_vbv {
    my ($bitrate, $bufsize, $fill) = @_;
    $bitrate /= $fps; # bit/frame
    for(0..$#sizes) {
        if($fill > $bufsize) { $fill = $bufsize }
        $fill -= $sizes[$_]*8;
        if($fill < 0) { return 0 }
        $fill += $bitrate;
    }
    return 1;
}

sub search_bitrate {
    my ($bufsize, $init) = @_;
    my $bitrate = 1;
    while(!check_vbv($bitrate, $bufsize, $init)) {
        $bitrate *= 2
    }
    my $step;
    for($step = $bitrate/2; $step > 1; $step /= 2) {
        if(check_vbv($bitrate-$step, $bufsize, $init)) {
            $bitrate -= $step;
        }
    }
    return $bitrate;
}

sub search_bufsize {
    my ($bitrate) = @_;
    my $bufsize = 1;
    while(!check_vbv($bitrate, $bufsize, $bufsize)) {
        $bufsize *= 2
    }
    for($step = $bufsize/2; $step > 1; $step /= 2) {
        if(check_vbv($bitrate, $bufsize-$step, $bufsize-$step)) {
            $bufsize -= $step;
        }
    }
    return $bufsize;
}

sub search_init {
    my ($bitrate, $bufsize) = @_;
    my $init = $bufsize;
    for($step = $bufsize/2; $step > 1; $step /= 2) {
        if(check_vbv($bitrate, $bufsize, $init-$step)) {
            $init -= $step;
        }
    }
    return $init;
}

if(defined($bitrate) && defined($bufsize) && defined($init)) {
    my $pass = check_vbv($bitrate, $bufsize, $init);
    printf "assuming bitrate: %d kbit/s\n", int($bitrate/1000+.5);
    printf "assuming buffer size: %d kbit\n", int($bufsize/1000+.999);
    printf "assuming initial fill: %d kbit\n", int($init/1000+.999);
    printf (($pass ? "passed" : "failed") . " vbv compliance\n");
} elsif(defined($bitrate) && defined($bufsize)) {
    my $pass = check_vbv($bitrate, $bufsize, $bufsize);
    if($pass) {
        $init = search_init($bitrate, $bufsize);
    }
    printf "assuming bitrate: %d kbit/s\n", int($bitrate/1000+.5);
    printf "assuming buffer size: %d kbit\n", int($bufsize/1000+.999);
    if($pass) {
        printf "minimum initial fill: %d kbit\n", int($init/1000+.999);
    } else {
        printf "failed vbv compliance\n";
    }
} elsif(defined($bitrate)) {
    $bufsize = search_bufsize($bitrate);
    $init = search_init($bitrate, $bufsize);
    printf "assuming bitrate: %d kbit/s\n", int($bitrate/1000+.5);
    printf "minimum buffer size: %d kbit\n", int($bufsize/1000+.999);
    printf "minimum initial fill: %d kbit\n", int($init/1000+.999);
} elsif(defined($bufsize) && defined($init)) {
    if($init < $sizes[0]*8) {
        $init = $sizes[0]*8;
    }
    $bitrate = search_bitrate($bufsize, $init);
    printf "assuming buffer size: %d kbit\n", int($bufsize/1000+.999);
    printf "assuming initial fill: %d kbit\n", int($init/1000+.999);
    printf "minimum bitrate: %d kbit/s\n", int($bitrate/1000+.5);
} elsif(defined($bufsize)) {
    $bitrate = search_bitrate($bufsize, $bufsize);
    $init = search_init($bitrate, $bufsize);
    printf "assuming buffer size: %d kbit\n", int($bufsize/1000+.999);
    printf "minimum initial fill: %d kbit\n", int($init/1000+.999);
    printf "minimum bitrate: %d kbit/s\n", int($bitrate/1000+.5);
} elsif(!defined($log)) {
    die $usage;
}
