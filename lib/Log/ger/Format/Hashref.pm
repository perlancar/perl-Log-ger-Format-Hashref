package Log::ger::Format::Hashref;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

sub get_hooks {
    my %conf = @_;

    return {
        create_formatter => [
            __PACKAGE__, # key
            50,          # priority
            sub {        # hook
                my %hook_args = @_; # see Log::ger::Manual::Internals/"Arguments passed to hook"

                my $formatter = sub {
                    if (@_ == 1) {
                        if (ref $_[0] eq 'HASH') {
                            return $_[0];
                        } else {
                            return {message=>$_[0]};
                        }
                    } elsif (@_ % 2) {
                        die "Please log an even number of arguments";
                    } else {
                        return {@_};
                    }
                };
                [$formatter];

            }],
    };
}

1;
# ABSTRACT: Format arguments as hashref

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Log::ger::Format 'Hashref';
 use Log::ger;

 # single argument, not hashref
 log_debug "arg";                          # becomes  : {message=>"arg"}

 # single argument, hashref
 log_debug {msg=>"arg"};                   # unchanged: {msg=>"arg"}

 # multiple arguments, odd numbered
 log_debug "arg1", "arg2", "arg3";         # dies!

 # multiple arguments, even numbered
 log_debug "arg1", "arg2", "arg3", "arg4"; # becomes  : {arg1=>"arg2", arg3=>"arg4"}

 log_debug "Data for %s is %s", "budi", {foo=>'blah', bar=>undef};


=head1 DESCRIPTION

EXPERIMENTAL.

This formatter tries to produce a single hashref from the arguments.


=head1 SEE ALSO

Other C<Log::ger::Format::*> plugins.

L<Log::ger>
