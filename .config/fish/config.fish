if status is-interactive
# Commands to run in interactive sessions can go here
end

bind \cf '~/.local/bin/tmux-sessions'

eval "$(/opt/homebrew/bin/brew shellenv fish)"

starship init fish | source

fzf --fish | source
