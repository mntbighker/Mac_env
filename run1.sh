#!/bin/zsh

say -v Rishi "Opening web pages related to this setup"
open "https://github.com/emilyst/home"
open "https://www.youtube.com/@typecraft_dev"
open "https://brew.sh"

if ! [ -f $HOME/Mac_env/.zshrc ]; then
  echo "Please git clone into $HOME before running run2.sh\n"
  exit
fi

echo "Building and installing some local binaries with Homebrew\n"
cd $HOME
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # requires sudo rights
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

say -v Rishi "Mission accomplished, well done"
