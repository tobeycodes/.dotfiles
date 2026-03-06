function gh
    set user $(git config user.github)
    if command gh auth status --json hosts --jq '.hosts["github.com"].[].login' | grep -Fqx "$user"
        echo "gh: switching to gh user '$user'"
        command gh auth switch -u "$user" >/dev/null 2>&1
    else
        echo "gh: matching gh user for git user '$user' not found"
    end

    command gh $argv
end
