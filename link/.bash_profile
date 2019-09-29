#!/bin/bash
# Make vim the default playa
export VISUAL=vim
export EDITOR="$VISUAL"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Setup git completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# Change git's language to english
alias git='LANG=en_US.UTF-8 git'

export PATH="$HOME/.cargo/bin:$PATH"
