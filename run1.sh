#!/bin/zsh

echo "Building and installing some local binaries with Homebrew\n"
cd $HOME
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # requires sudo rights
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

say -v Rishi "Mission accomplished, well done"
