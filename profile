# ~/.profile contains common configuration for bourne compatible shells.

if [ -d "$HOME/.profile.d" ]; then
  for i in $HOME/.profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

if [ -d "$HOME/.third_party/profile.d" ]; then
  for i in $HOME/.third_party/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
