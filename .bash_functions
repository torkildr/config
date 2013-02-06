#!/bin/bash

# add the following to your .bashrc
# . ~/.bash_functions

function rnoridwhois() {
    whois $(whois $1 | grep "NORID Handle" | tail -1 | sed 's/.*\.\.: //') \
        | grep Domains \
        | sed 's/.*\.\.: //' \
        | sed 's/ /\n/g' \
        | sort
}

function openssl_https() {
    addr=$1

    if [[ ! "$addr" =~ [:] ]]
    then
        addr="${addr}:443"
    fi

    openssl s_client -connect $addr
}

function openssl_smtp() {
    addr=$1

    if [[ ! "$addr" =~ [:] ]]
    then
        addr="${addr}:25"
    fi

    openssl s_client -starttls smtp -crlf -connect $addr
}

