test (uname) != Darwin && exit

set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
set -gx HOMEBREW_NO_ENV_HINTS 1

fish_add_path /opt/homebrew/opt/curl/bin
fish_add_path /opt/homebrew/opt/libpq/bin

eval "$(/opt/homebrew/bin/brew shellenv fish)"
