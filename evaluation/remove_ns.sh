#!/usr/bin/env bash

# This script is needed because some of the TAR run files from participants are malformed.
# The following code removes lines that contain NS from these files.

awk '$2 == "NS" { next } { print }' $1 > $1.tmp
mv $1.tmp $1
