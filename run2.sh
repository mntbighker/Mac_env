#!/bin/zsh

if ! [ -f $HOME/Mac_env/.tmux.conf ]; then
  echo "Please git clone into $HOME before running run2.sh\n"
  exit
fi

export PATH=$HOME/local/bin:$PATH
port selfupdate && port upgrade outdated
port -N install autoconf automake bison bison-runtime boost176 brotli bzip2 cargo cmake cmake-bootstrap curl curl-ca-bundle docbook-xml docbook-xsl-nons expat gettext gettext-runtime gettext-tools-libs gmp gperf icu libarchive libb2 libcxx libedit libevent libffi libgit2 libiconv libidn2 libpsl libssh2 libtermkey libtextstyle libtool libunistring libutf8proc libuv libvterm libxml2 lua51 lua51-lpeg lua51-luarocks lua51-mpack luajit luarocks_select luv-luajit lz4 lzma lzo2 m4 msgpack msgpack-c msgpack-cpp ncurses neovim nghttp2 ninja nodejs19 npm9 openssl openssl3 p7zip pcre2 pkgconfig python3_select python311 python_select re2c readline rlwrap ruby27 ruby32 rust sqlite3 tmux tmux-pasteboard tree-sitter-cli unibilium wget xmlcatmgr xz zlib zstd
port -f activate python311
port -f activate ruby32
port -f activate lua51-luarocks
port select --set python python311
port select --set python3 python311
port select --set pygments py311-pygments
port select --set luarocks lua51-luarocks
port select --set ruby ruby32

echo "Downloading fancy bitmap fonts\n"
cd ~/Library/Fonts && {
wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip'
unzip Hack '*.ttf' -x '*Windows*'
rm Hack.zip
wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip'
unzip Meslo '*.ttf' -x '*Windows*'
rm Meslo.zip
}

cd $HOME
rm -rf ~/.config
mv Mac_env/.config .
mv Mac_env/.tmux.conf .

echo 
wget 'https://iterm2.com/downloads/stable/iTerm2-3_4_19.zip'
unzip iTerm2-3_4_19.zip
if ! [ -d $HOME/Applications ]; then
  mkdir $HOME/Applications
fi
mv iTerm.app $HOME/Applications

echo "### Type exit after the oh-my-zsh script finishes, to complete setup ###\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
echo "## Change Terminal, iTerm2 font settings to Hack or Meslo to get the fancy bitmap icons ##\n"

rm ~/.zshrc.pre-oh-my-zsh
rm ~/.zshrc
mv Mac_env/.zshrc .
rm -rf ~/Mac_env

echo "Installing ruby colorls gem\n"
gem install colorls
echo "You can add 'alias ls=colorls' to .zshrc to get the fancy one every time\n"
echo "The command to run in each iTerm profile: \n\nssh -t ssh_config_alias_name 'tmux -CC new -A -s main' \n"
echo "Run 'p10k configure' to customize the shell prompt\n"

say -v Rishi "Mission accomplished"
