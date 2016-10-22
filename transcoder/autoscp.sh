#!/usr/bin/expect
if {$argc < 2} {
        send_user "usage: $argv0 src_file username ip dest_file password\n"
exit
}
##set key [lindex $argv 0]
set src_file [lindex $argv 0]
set username [lindex $argv 1]
set host_ip [lindex $argv 2]
set dest_file [lindex $argv 3]
set password [lindex $argv 4]
##spawn scp -i $key $src_file $username@$host_ip:$dest_file
spawn scp  $src_file $username@$host_ip:$dest_file
expect {
        "(yes/no)?" { send "yes\n"
                        expect "password:" {send "$password\n"}
                }
        "password:" { send "$password\n" }
}
expect "100%"
expect eof