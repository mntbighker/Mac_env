#!/bin/zsh

open https://github.com/emilyst/home

cd $HOME
curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.8.1.tar.bz2
tar xf MacPorts-2.8.1.tar.bz2
cd MacPorts-2.8.1
./configure --prefix=$HOME/local --with-install-user=$USER --with-install-group=staff --without-startupitems
make && make install
cd $HOME
rm -rf MacPorts-2.8.1 && rm MacPorts-2.8.1.tar.bz2

say "Mission accomplished"
