#!/bin/sh

# For this script to work you need to do
# sudo apt install autoconf
# And maybe automake too?

autoconf configure.ac > configure

# pyconf makes a bunch of cruft that we don't need after configure has been generated, so we delete it
rm -rf autom4te.cache

# Trim away all the directory variables we don't use, so as not to confuse users
for DIRNAME in doc bin sbin sharedstate localstate locale libexec runstate include oldinclude dataroot data info man html dvi pdf ps; do
    sed -i -e "/-${DIRNAME}dir | --${DIRNAME}dir/,/^$/d" configure
    sed -i -e "/--${DIRNAME}dir=DIR/d" configure
    sed -i -e "/^${DIRNAME}$/d" configure
    sed -i -e "/^${DIRNAME}=/d" configure
done
sed -i -e '/\[DATAROOTDIR\/doc\/.*\]/d' configure
