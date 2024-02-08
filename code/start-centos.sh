#!/bin/bash
set -exo

sudo yum install -y mongodb-org
chmod +x *.sh
. ./start.sh