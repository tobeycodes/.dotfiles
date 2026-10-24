test (uname) != Darwin && exit

set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
set -gx HOMEBREW_NO_ENV_HINTS 1

eval "$(/opt/homebrew/bin/brew shellenv fish)"
