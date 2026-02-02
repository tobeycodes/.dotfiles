# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_anchor_global_optspecs
	string join \n provider.cluster= provider.wallet= h/help V/version
end

function __fish_anchor_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_anchor_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_anchor_using_subcommand
	set -l cmd (__fish_anchor_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c anchor -n "__fish_anchor_needs_command" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_needs_command" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_needs_command" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_needs_command" -s V -l version -d 'Print version'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "init" -d 'Initializes a workspace'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "build" -d 'Builds the workspace'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "expand" -d 'Expands macros (wrapper around cargo expand)'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "verify" -d 'Verifies the on-chain bytecode matches the locally compiled artifact. Run this command inside a program subdirectory, i.e., in the dir containing the program\'s Cargo.toml'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "test" -d 'Runs integration tests'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "new" -d 'Creates a new program'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "idl" -d 'Commands for interacting with interface definitions'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "clean" -d 'Remove all artifacts from the generated directories except program keypairs'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "deploy" -d 'Deploys each program in the workspace'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "migrate" -d 'Runs the deploy migration script'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "upgrade" -d 'Deploys, initializes an IDL, and migrates all in one command. Upgrades a single program. The configured wallet must be the upgrade authority'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "cluster" -d 'Cluster commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "shell" -d 'Starts a node shell with an Anchor client setup according to the local config'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "run" -d 'Runs the script defined by the current workspace\'s Anchor.toml'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "login" -d 'Saves an api token from the registry locally'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "keys" -d 'Program keypair commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "localnet" -d 'Localnet commands'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "account" -d 'Fetch and deserialize an account using the IDL provided'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "completions" -d 'Generates shell completions'
complete -c anchor -n "__fish_anchor_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l package-manager -d 'Package Manager to use' -r -f -a "{npm\t'Use npm as the package manager',yarn\t'Use yarn as the package manager',pnpm\t'Use pnpm as the package manager',bun\t'Use bun as the package manager'}"
complete -c anchor -n "__fish_anchor_using_subcommand init" -s t -l template -d 'Rust program template to use' -r -f -a "{single\t'Program with a single `lib.rs` file',multiple\t'Program with multiple files for instructions, state...'}"
complete -c anchor -n "__fish_anchor_using_subcommand init" -l test-template -d 'Test template to use' -r -f -a "{mocha\t'Generate template for Mocha unit-test',jest\t'Generate template for Jest unit-test',rust\t'Generate template for Rust unit-test',mollusk\t'Generate template for Mollusk Rust unit-test'}"
complete -c anchor -n "__fish_anchor_using_subcommand init" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand init" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand init" -s j -l javascript -d 'Use JavaScript instead of TypeScript'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l no-install -d 'Don\'t install JavaScript dependencies'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l no-git -d 'Don\'t initialize git'
complete -c anchor -n "__fish_anchor_using_subcommand init" -l force -d 'Initialize even if there are files'
complete -c anchor -n "__fish_anchor_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anchor -n "__fish_anchor_using_subcommand build" -s i -l idl -d 'Output directory for the IDL' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s t -l idl-ts -d 'Output directory for the TypeScript IDL' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s p -l program-name -d 'Name of the program to build' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s s -l solana-version -d 'Version of the Solana toolchain to use. For --verifiable builds only' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s d -l docker-image -d 'Docker image to use. For --verifiable builds only' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -s b -l bootstrap -d 'Bootstrap docker image from scratch, installing all requirements for verifiable builds. Only works for debian-based images' -r -f -a "{none\t'',debian\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand build" -s e -l env -d 'Environment variables to pass into the docker container' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l arch -d 'Architecture to use when building the program' -r -f -a "{bpf\t'',sbf\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand build" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand build" -l skip-lint -d 'True if the build should not fail even if there are no "CHECK" comments'
complete -c anchor -n "__fish_anchor_using_subcommand build" -l no-idl -d 'Do not build the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand build" -s v -l verifiable -d 'True if the build artifact needs to be deterministic and verifiable'
complete -c anchor -n "__fish_anchor_using_subcommand build" -l no-docs -d 'Suppress doc strings in IDL output'
complete -c anchor -n "__fish_anchor_using_subcommand build" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand expand" -s p -l program-name -d 'Expand only this program' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand expand" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l repo-url -d 'The URL of the repository to verify against. Conflicts with `--current-dir`' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l commit-hash -d 'The commit hash to verify against. Requires `--repo-url`' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l program-name -d 'Name of the program to run the command on. Defaults to the package name' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand verify" -l current-dir -d 'Verify against the source code in the current directory. Conflicts with `--repo-url`'
complete -c anchor -n "__fish_anchor_using_subcommand verify" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand test" -s p -l program-name -d 'Build and test only this program' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l arch -d 'Architecture to use when building the program' -r -f -a "{bpf\t'',sbf\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand test" -l run -d 'Run the test suites under the specified path' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -s e -l env -d 'Environment variables to pass into the docker container' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-deploy -d 'Use this flag if you want to run tests against previously deployed programs'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-lint -d 'True if the build should not fail even if there are no "CHECK" comments where normally required'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-local-validator -d 'Flag to skip starting a local validator, if the configured cluster url is a localnet'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l skip-build -d 'Flag to skip building the program in the workspace, use this to save time when running test and the program code is not altered'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l no-idl -d 'Do not build the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand test" -l detach -d 'Flag to keep the local validator running after tests to be able to check the transactions'
complete -c anchor -n "__fish_anchor_using_subcommand test" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand new" -s t -l template -d 'Rust program template to use' -r -f -a "{single\t'Program with a single `lib.rs` file',multiple\t'Program with multiple files for instructions, state...'}"
complete -c anchor -n "__fish_anchor_using_subcommand new" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand new" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand new" -l force -d 'Create new program even if there is already one'
complete -c anchor -n "__fish_anchor_using_subcommand new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "init" -d 'Initializes a program\'s IDL account. Can only be run once'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "close"
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "write-buffer" -d 'Writes an IDL into a buffer account. This can be used with SetBuffer to perform an upgrade'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "set-buffer" -d 'Sets a new IDL buffer for the program'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "upgrade" -d 'Upgrades the IDL to the new file. An alias for first writing and then then setting the idl buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "set-authority" -d 'Sets a new authority on the IDL account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "erase-authority" -d 'Command to remove the ability to modify the IDL account. This should likely be used in conjection with eliminating an "upgrade authority" on the program'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "authority" -d 'Outputs the authority for the IDL account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "build" -d 'Generates the IDL for the program using the compilation method'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "fetch" -d 'Fetches an IDL for the given address from a cluster. The address can be a program, IDL account, or IDL buffer'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "convert" -d 'Convert legacy IDLs (pre Anchor 0.30) to the new IDL spec'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "type" -d 'Generate TypeScript type for the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and not __fish_seen_subcommand_from init close write-buffer set-buffer upgrade set-authority erase-authority authority build fetch convert type help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -s f -l filepath -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l idl-address -d 'The IDL account to close. If none is given, then the IDL account derived from program_id is used' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -l print-only -d 'When used, the content of the instruction will only be printed in base64 form and not executed. Useful for multisig execution when the local wallet keypair is not available'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from close" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -s f -l filepath -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from write-buffer" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer" -s b -l buffer -d 'Address of the buffer account to set as the idl on the program' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer" -l print-only -d 'When used, the content of the instruction will only be printed in base64 form and not executed. Useful for multisig execution when the local wallet keypair is not available'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-buffer" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -s f -l filepath -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from upgrade" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -s p -l program-id -d 'Program to change the IDL authority' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -s n -l new-authority -d 'New authority of the IDL account' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -l print-only -d 'When used, the content of the instruction will only be printed in base64 form and not executed. Useful for multisig execution when the local wallet keypair is not available'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from set-authority" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from erase-authority" -s p -l program-id -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from erase-authority" -l priority-fee -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from erase-authority" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from erase-authority" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from erase-authority" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from authority" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from authority" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from authority" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s p -l program-name -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s t -l out-ts -d 'Output file for the TypeScript IDL' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l no-docs -d 'Suppress doc strings in output'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -l skip-lint -d 'Do not check for safety comments'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from build" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from fetch" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -s p -l program-id -d 'Address to use (defaults to `metadata.address` value)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from convert" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -s o -l out -d 'Output file for the IDL (stdout if not specified)' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from type" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initializes a program\'s IDL account. Can only be run once'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "close"
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "write-buffer" -d 'Writes an IDL into a buffer account. This can be used with SetBuffer to perform an upgrade'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "set-buffer" -d 'Sets a new IDL buffer for the program'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "upgrade" -d 'Upgrades the IDL to the new file. An alias for first writing and then then setting the idl buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "set-authority" -d 'Sets a new authority on the IDL account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "erase-authority" -d 'Command to remove the ability to modify the IDL account. This should likely be used in conjection with eliminating an "upgrade authority" on the program'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "authority" -d 'Outputs the authority for the IDL account'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "build" -d 'Generates the IDL for the program using the compilation method'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "fetch" -d 'Fetches an IDL for the given address from a cluster. The address can be a program, IDL account, or IDL buffer'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "convert" -d 'Convert legacy IDLs (pre Anchor 0.30) to the new IDL spec'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "type" -d 'Generate TypeScript type for the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand idl; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand clean" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand clean" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand clean" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -s p -l program-name -d 'Only deploy this program' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l program-keypair -d 'Keypair of the program (filepath) (requires program-name)' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -s v -l verifiable -d 'If true, deploy from path target/verifiable'
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -l no-idl -d 'Don\'t upload IDL during deployment (IDL is uploaded by default)'
complete -c anchor -n "__fish_anchor_using_subcommand deploy" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand migrate" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -s p -l program-id -d 'The program to upgrade' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l max-retries -d 'Max times to retry on failure' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand upgrade" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -f -a "list" -d 'Prints common cluster urls'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and not __fish_seen_subcommand_from list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from help" -f -a "list" -d 'Prints common cluster urls'
complete -c anchor -n "__fish_anchor_using_subcommand cluster; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand shell" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand shell" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand shell" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand run" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand run" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand run" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand login" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand login" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand login" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -f -a "list" -d 'List all of the program keys'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -f -a "sync" -d 'Sync program `declare_id!` pubkeys with the program\'s actual pubkey'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and not __fish_seen_subcommand_from list sync help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -s p -l program-name -d 'Only sync the given program instead of all programs' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from sync" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all of the program keys'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from help" -f -a "sync" -d 'Sync program `declare_id!` pubkeys with the program\'s actual pubkey'
complete -c anchor -n "__fish_anchor_using_subcommand keys; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l arch -d 'Architecture to use when building the program' -r -f -a "{bpf\t'',sbf\t''}"
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -s e -l env -d 'Environment variables to pass into the docker container' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l skip-build -d 'Flag to skip building the program in the workspace, use this to save time when running test and the program code is not altered'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l skip-deploy -d 'Use this flag if you want to run tests against previously deployed programs'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -l skip-lint -d 'True if the build should not fail even if there are no "CHECK" comments where normally required'
complete -c anchor -n "__fish_anchor_using_subcommand localnet" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand account" -l idl -d 'IDL to use (defaults to workspace IDL)' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand account" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand completions" -l provider.cluster -d 'Cluster override' -r
complete -c anchor -n "__fish_anchor_using_subcommand completions" -l provider.wallet -d 'Wallet override' -r
complete -c anchor -n "__fish_anchor_using_subcommand completions" -s h -l help -d 'Print help'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "init" -d 'Initializes a workspace'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "build" -d 'Builds the workspace'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "expand" -d 'Expands macros (wrapper around cargo expand)'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "verify" -d 'Verifies the on-chain bytecode matches the locally compiled artifact. Run this command inside a program subdirectory, i.e., in the dir containing the program\'s Cargo.toml'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "test" -d 'Runs integration tests'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "new" -d 'Creates a new program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "idl" -d 'Commands for interacting with interface definitions'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "clean" -d 'Remove all artifacts from the generated directories except program keypairs'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "deploy" -d 'Deploys each program in the workspace'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "migrate" -d 'Runs the deploy migration script'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "upgrade" -d 'Deploys, initializes an IDL, and migrates all in one command. Upgrades a single program. The configured wallet must be the upgrade authority'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "cluster" -d 'Cluster commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "shell" -d 'Starts a node shell with an Anchor client setup according to the local config'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "run" -d 'Runs the script defined by the current workspace\'s Anchor.toml'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "login" -d 'Saves an api token from the registry locally'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "keys" -d 'Program keypair commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "localnet" -d 'Localnet commands'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "account" -d 'Fetch and deserialize an account using the IDL provided'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "completions" -d 'Generates shell completions'
complete -c anchor -n "__fish_anchor_using_subcommand help; and not __fish_seen_subcommand_from init build expand verify test new idl clean deploy migrate upgrade cluster shell run login keys localnet account completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "init" -d 'Initializes a program\'s IDL account. Can only be run once'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "close"
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "write-buffer" -d 'Writes an IDL into a buffer account. This can be used with SetBuffer to perform an upgrade'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "set-buffer" -d 'Sets a new IDL buffer for the program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "upgrade" -d 'Upgrades the IDL to the new file. An alias for first writing and then then setting the idl buffer account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "set-authority" -d 'Sets a new authority on the IDL account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "erase-authority" -d 'Command to remove the ability to modify the IDL account. This should likely be used in conjection with eliminating an "upgrade authority" on the program'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "authority" -d 'Outputs the authority for the IDL account'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "build" -d 'Generates the IDL for the program using the compilation method'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "fetch" -d 'Fetches an IDL for the given address from a cluster. The address can be a program, IDL account, or IDL buffer'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "convert" -d 'Convert legacy IDLs (pre Anchor 0.30) to the new IDL spec'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from idl" -f -a "type" -d 'Generate TypeScript type for the IDL'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from cluster" -f -a "list" -d 'Prints common cluster urls'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keys" -f -a "list" -d 'List all of the program keys'
complete -c anchor -n "__fish_anchor_using_subcommand help; and __fish_seen_subcommand_from keys" -f -a "sync" -d 'Sync program `declare_id!` pubkeys with the program\'s actual pubkey'
