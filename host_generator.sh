#!/bin/bash

function write_begin_comment_to_file()
{
    echo -e "\n # $1" >> hosts
}

function write_host_to_file() {
    echo "$1    $2" >> hosts
}

function get_ip_from_domain() {
    local domain=$1
    ip=`nslookup ${domain} | grep "Address: " | awk 'NR==1 {print $NF}'`
    echo $ip
}

function write_hosts() {
    hosts=$1
    for host in ${hosts[*]}; do
        [[ -z ${host} ]] && {
            continue;
        }
        ip=$(get_ip_from_domain ${host})
        write_host_to_file ${ip} ${host}
    done
}

function write_github_hosts() {
    local hosts=(
        "github.global.ssl.fastly.net"
        "github-atom-io-herokuapp-com.freetls.fastly.net"
        "gist.github.com"
        "github.com"
        "avatars0.githubusercontent.com"
        "avatars1.githubusercontent.com"
        "avatars2.githubusercontent.com"
        "avatars3.githubusercontent.com"
        "avatars4.githubusercontent.com"
        "avatars5.githubusercontent.com"
        "avatars6.githubusercontent.com"
        "avatars7.githubusercontent.com"
        "avatars8.githubusercontent.com"
        "camo.githubusercontent.com"
        "cloud.githubusercontent.com"
        "gist.githubusercontent.com"
        "marketplace-screenshots.githubusercontent.com"
        "raw.githubusercontent.com"
        "repository-images.githubusercontent.com"
        "user-images.githubusercontent.com"
    )
    write_begin_comment_to_file github
    write_hosts ${hosts}
}

function write_localhost_hosts() {
cat > hosts <<EOF
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
EOF
}

function main() {
    write_localhost_hosts
    
    write_github_hosts
}

main