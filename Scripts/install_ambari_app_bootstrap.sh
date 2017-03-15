#!/bin/bash

SCRIPT_BASE=${1%/}
shift
echo "Downloading python scripts to /tmp"
wget $SCRIPT_BASE/install_ambari_application.py -O /tmp/install_ambari_application.py
wget $SCRIPT_BASE/shared_ambari_installation.py -O /tmp/shared_ambari_installation.py

echo "PIP installing dependencies (purl & python-ambariclient)"
pip install purl
pip install python-ambariclient

echo "Running python script to install Ambari service"
mkdir /var/log/install-ambari-app
logarg='-l /var/log/install-ambari-app/install.log'
for arg in "$@"; do
    if [ "$arg" == "-l" ] || [ "$arg" == "--logfile" ] ; then
        logarg=''
    fi
done
python /tmp/install_ambari_application.py $logarg $@
