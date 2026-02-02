if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting

set --export ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $ANDROID_HOME/emulator $PATH;
set -gx PATH $ANDROID_HOME/platform-tools $PATH;

fish_add_path $HOME/.local/share/solana/install/active_release/bin

bind \cf '~/.local/bin/tmux-sessions'

eval "$(/opt/homebrew/bin/brew shellenv fish)"

starship init fish | source

fzf --fish | source

zoxide init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .... 'cd ../../..'
abbr --add - 'cd -'
abbr --add 1 'prevd 1'
abbr --add 2 'prevd 2'
abbr --add 3 'prevd 3'
abbr --add 4 'prevd 4'
abbr --add 5 'prevd 5'
abbr --add 6 'prevd 6'
abbr --add 7 'prevd 7'
abbr --add 8 'prevd 8'
abbr --add 9 'prevd 9'
abbr --add md 'mkdir -p'
abbr --add rd 'rmdir'
abbr --add l   'ls -lah'
abbr --add ll  'ls -lh'
abbr --add la  'ls -lAh'
abbr --add lsa 'ls -lah'
abbr --add lg 'lazygit'
