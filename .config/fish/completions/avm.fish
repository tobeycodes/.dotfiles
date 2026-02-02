# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_avm_global_optspecs
	string join \n h/help V/version
end

function __fish_avm_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_avm_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_avm_using_subcommand
	set -l cmd (__fish_avm_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c avm -n "__fish_avm_needs_command" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_needs_command" -s V -l version -d 'Print version'
complete -c avm -n "__fish_avm_needs_command" -f -a "use" -d 'Use a specific version of Anchor'
complete -c avm -n "__fish_avm_needs_command" -f -a "install" -d 'Install a version of Anchor'
complete -c avm -n "__fish_avm_needs_command" -f -a "uninstall" -d 'Uninstall a version of Anchor'
complete -c avm -n "__fish_avm_needs_command" -f -a "list" -d 'List available versions of Anchor'
complete -c avm -n "__fish_avm_needs_command" -f -a "update" -d 'Update to the latest Anchor version'
complete -c avm -n "__fish_avm_needs_command" -f -a "completions" -d 'Generate shell completions for AVM'
complete -c avm -n "__fish_avm_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c avm -n "__fish_avm_using_subcommand use" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_using_subcommand install" -l path -d 'Path to local anchor repo, conflicts with `version_or_commit`' -r
complete -c avm -n "__fish_avm_using_subcommand install" -l force -d 'Flag to force installation even if the version is already installed'
complete -c avm -n "__fish_avm_using_subcommand install" -l from-source -d 'Build from source code rather than downloading prebuilt binaries'
complete -c avm -n "__fish_avm_using_subcommand install" -l verify -d 'Install `solana-verify` as well'
complete -c avm -n "__fish_avm_using_subcommand install" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_using_subcommand uninstall" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_using_subcommand list" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_using_subcommand update" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_using_subcommand completions" -s h -l help -d 'Print help'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "use" -d 'Use a specific version of Anchor'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "install" -d 'Install a version of Anchor'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "uninstall" -d 'Uninstall a version of Anchor'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "list" -d 'List available versions of Anchor'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "update" -d 'Update to the latest Anchor version'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "completions" -d 'Generate shell completions for AVM'
complete -c avm -n "__fish_avm_using_subcommand help; and not __fish_seen_subcommand_from use install uninstall list update completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
