
# execute .profile if it persents
if [ -f $HOME/.profile ]; then
    . $HOME/.profile
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
