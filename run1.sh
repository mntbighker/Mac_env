#!/bin/zsh

say -v Rishi "Opening web pages related to this setup"
open "https://github.com/emilyst/home"
open "https://www.youtube.com/@typecraft_dev"
open "https://brew.sh"
open "https://www.josean.com/posts/tmux-setup"

if ! [ -f $HOME/Mac_env/.tmux.conf ]; then
  echo "Please git clone into $HOME before running run2.sh\n"
  exit
fi

echo "Building and installing some local binaries with Homebrew\n"
cd $HOME
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"tar xf MacPorts-2.9.3.tar.bz2 # requires sudo rights

say -v Rishi "Mission accomplished, well done"
