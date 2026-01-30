if status is-interactive
# Commands to run in interactive sessions can go here
end

set --export ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $ANDROID_HOME/emulator $PATH;
set -gx PATH $ANDROID_HOME/platform-tools $PATH;

bind \cf '~/.local/bin/tmux-sessions'

eval "$(/opt/homebrew/bin/brew shellenv fish)"

starship init fish | source

fzf --fish | source

zoxide init fish | source
