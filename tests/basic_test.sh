#!/bin/bash

# script for testing basic functionality

set -e
set -x

AUTH=~/.pcloud_auth
TESTDIR="$(dirname $0)"
export PATH="$TESTDIR/../:$PATH"
TESTFOLDER=$RANDOM

cd "$TESTDIR"
chmod +w -R playground
rm -rf playground
mkdir playground
cd playground

git init && git annex init
git annex initremote mypcloud type=external externaltype=pcloud \
    path=/test_git_annex/$TESTFOLDER credentials_file="$AUTH" \
    encryption=none

for x in `seq 1 9`; do
    echo $x > $x.txt
done
dd if=/dev/zero of=zeroes.bin count=12345 bs=1024

git annex add *
git annex copy * --to mypcloud
git annex fsck * --from mypcloud | tee test.log
cat test.log | grep checksum | wc -l | grep 10 -q
cat test.log | grep '^ok$' | wc -l | grep 10 -q

# clear annex storage
python3 <<EOF
import sys
sys.path.insert(0, "../../python3-pcloudapi")
from pcloudapi import PCloudAPI
a=PCloudAPI()
a.auth = open("$AUTH", 'r').read().strip()
a.deletefolderrecursive(path="/test_git_annex/$TESTFOLDER")
EOF

