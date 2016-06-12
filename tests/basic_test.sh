#!/bin/bash

# script for testing basic functionality

set -e
set -x

AUTH=~/.pcloud_auth
TESTDIR="$(dirname $0)"
TESTFOLDER=$RANDOM

cd "$TESTDIR"
chmod u+w -R playground || true
rm -rf playground
mkdir playground
cd playground
export PATH="$PWD/../../:$PATH"

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
git annex fsck * --from mypcloud --numcopies=2 | tee test.log
cat test.log | grep checksum | wc -l | grep 10 -q \
    || (echo 'ERROR: expected checksums not performed' && exit 1)
cat test.log | grep 'ok$' | wc -l | grep 10 -q \
    || (echo 'ERROR: wrong number of oks' && exit 1)

# clear annex storage
chmod u+w -R ../playground
python3 <<EOF
import sys
sys.path.insert(0, "../../python3-pcloudapi")
from pcloudapi import PCloudAPI
a = PCloudAPI()
creds = open("$AUTH", 'r').read().strip().splitlines()
if len(creds) == 2:
    a.login(*creds)
else:
    a.auth = creds[0]
a.deletefolderrecursive(path="/test_git_annex/$TESTFOLDER")
EOF

echo "ALL DONE"
