#!/bin/zsh

if ! [ -f $HOME/Mac_env/.zshrc ]; then
  echo "Please git clone into $HOME before running run2.sh\n"
  exit
fi

brew update
# port -N install autoconf automake bison bison-runtime boost176 brotli bzip2 cargo cmake cmake-bootstrap curl curl-ca-bundle docbook-xml docbook-xsl-nons expat gettext gettext-runtime gettext-tools-libs gmp gperf icu libarchive libb2 libcxx libedit libevent libffi libgit2 libiconv libidn2 libpsl libssh2 libtermkey libtextstyle libtool libunistring libutf8proc libuv libvterm libxml2 lua51 lua51-lpeg lua51-luarocks lua51-mpack luajit luarocks_select luv-luajit lz4 lzma lzo2 m4 msgpack msgpack-c msgpack-cpp ncurses neovim nghttp2 ninja nodejs19 npm9 openssl openssl3 p7zip pcre2 pkgconfig python3_select python311 python_select re2c readline rlwrap rust sqlite3 tmux tmux-pasteboard tree-sitter-cli unibilium wget xmlcatmgr xz zlib zstd
brew install npm neovim wget lazygit cmake efm-langserver luarocks

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
cd ~/.config
git clone https://github.com/radleylewis/nvim.git
cd $HOME

echo 
wget 'https://iterm2.com/downloads/stable/iTerm2-3_5_10.zip'
unzip iTerm2-3_5_10.zip
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

brew install fzf
cat << 'EOF' >> ~/.zshrc
# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
EOF
source ~/.zshrc

brew install fd
cat << 'EOF' >> ~/.zshrc

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

EOF
source ~/.zshrc

cat << 'EOF' >> ~/.zshrc

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
EOF
source ~/.zshrc

brew install zoxide
# https://github.com/nanotee/zoxide
cat << 'EOF' >> ~/.zshrc

eval "$(zoxide init zsh --cmd cd)"
EOF

brew install eza
cat << 'EOF' >> $HOME/.zshrc

alias ls='eza'
EOF

echo "The command to run in each iTerm profile: \n\nssh -t ssh_config_alias_name 'tmux -CC new -A -s main' \n"
echo "Run 'p10k configure' to customize the shell prompt\n"

# https://github.com/sxyazi/yazi
brew install yazi ffmpeg sevenzip jq poppler ripgrep imagemagick font-symbols-only-nerd-font

cat << 'EOF' >> ~/.zshrc
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
EOF

say -v Rishi "Mission accomplished"
