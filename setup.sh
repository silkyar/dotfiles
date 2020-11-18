#!/usr/bin/env zsh

# Requirements: iterm2 and zsh, homebrew, python-pip
# Set zsh as default: chsh -s /bin/zsh

# Update submodules
git submodule update --init --recursive --remote

# Install deps
pip install pre-commit yapf tabcompletion cpplint ptpython pdbpp || true
brew install clang-format the_silver_searcher hub || true
# For tmux to access clipboard: https://blog.carbonfive.com/copying-and-pasting-with-tmux-2-4/
brew install reattach-to-user-namespace || true

# Install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Install antigen (for easier third-party plugin management than oh-my-zsh)
curl -L git.io/antigen > ~/.antigen.zsh

# Setup symlinks to homedir
for f in $(ls -a | grep '^\.')
do
  if ! [[ ($f == .)  || ($f == ..) || ($f =~ .git*) ]]
  then
    echo "Symlink: ~/$f -> $(pwd)/$f"
    ln -sf $(pwd)/$f ~/
  fi
done

echo "Done setting up dotfiles!"
