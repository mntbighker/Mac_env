#!/bin/zsh

echo "Opening two web pages related to this setup\n"
open "https://github.com/emilyst/home"
open "https://www.youtube.com/@typecraft_dev"

if ! [ -f $HOME/Mac_env/.tmux.conf ]; then
  echo "Please git clone into $HOME before running run2.sh\n"
  exit
fi

echo "Building and installing some local binaries\n"
cd $HOME
curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.8.1.tar.bz2
tar xf MacPorts-2.8.1.tar.bz2
cd MacPorts-2.8.1
./configure --prefix=$HOME/local --with-install-user=$USER --with-install-group=staff --without-startupitems
make && make install
cd $HOME
rm -rf MacPorts-2.8.1 && rm MacPorts-2.8.1.tar.bz2

say -v Rishi "Mission accomplished, well done"
