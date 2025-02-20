#!/bin/bash

cat sum.txt | echo $[ $( tr '\n' '+' ) 0 ]

md5sum file.txt > file.md5

openssl passwd -1 -salt adadad 16351018

