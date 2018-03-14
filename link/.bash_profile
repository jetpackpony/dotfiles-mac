#!/bin/bash
# Make vim the default playa
export VISUAL=nvim
export EDITOR="$VISUAL"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setup git completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Setup JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# Setup google cloud sdk
GCSDK_DIR="$HOME/google-cloud-sdk"
[ -s "$GCSDK_DIR/completion.bash.inc" ] && \. "$GCSDK_DIR/completion.bash.inc"
[ -s "$GCSDK_DIR/path.bash.inc" ] && \. "$GCSDK_DIR/path.bash.inc"

# Setup virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh

# Setup autoenv
export AUTOENV_ENABLE_LEAVE="true"
source /usr/local/opt/autoenv/activate.sh
