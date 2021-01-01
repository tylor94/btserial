#!/bin/bash

# Formatting variables
padding="echo"
newline="\n"

# Make symlinks from external confgs in folders
ln -s /etc/aprx.conf ../conf/ ;\
ln -s /etc/ser2net.conf ../conf/ ;\
ln -s ../conf/* ./ ;\
ln -s ../conf2/* ./ ;\
# Also make folder var
mkdir ../var/ ;\
