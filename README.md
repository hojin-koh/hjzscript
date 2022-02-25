# hjzscript

Hojin's zsh scripting framework. This library is heavily opinionated and is geared toward simple scripts that does only one thing per script.

## Basics

The basic usage of this framework looks like this, which basically does nothing:

```zsh
#!/usr/bin/env zsh
desc="Test if a simple script can be run"

main() {
  echo The main script goes here
}

source "${0:a:h}/deps/hjzscript/go" # where this library is stored
```

`desc` variable is reserved for the description of the script, which is used in the auto-generated help message

`main` function is the things to be actually run

The output looks like this:

```
[I-0000.0] > Begin ./scriptname.zsh
[I-0000.0] 2021-09-20 14:09:59 (SHLVL=5)
The main script goes here
[I-0000.0] < End ./scriptname.zsh
```

The main added functionalities of this library are:
- Opinionated colorful messages
- Command-line parsing
- Need-to-run check
- Pre/post-script hooks
- Temp directory management
- Logging

### Colorful messages

`debug` command puts text into the log file only, not to the screen. All other commands in this section will output both to the screen (in color) and to the log file (no color).

`info` command outputs bright white info messages with a timestamp, just like the example in the **Basics** section.

`warn` command outputs yellow warning text with a timestamp

`err` command outputs red error message with a timestamp and exits. If there's second parameter after the actual message, it will be used as the return value when exiting.

`prompt` command asks user a question, and stores the reply in `$REPLY` variable

`promptyn` command asks user a yes/no question, and stores the reply in `$REPLY` variable

### Command-line

Typing `./scriptname.zsh --help` will display an auto-generated help message, showing available options. If wrong options are given at the command line, the help message will also be displayed along with the error message.

`opt` command declares an option, the usage is: `opt [-r] <opt-name> <default-value> <description>`

`-r` means this option is mandatory, and it will be an error if this value is empty. If a required argument is empty, but some positional arguments are given, these positional arguments will be used to fill in the required arguments in order.

`<opt-name>` is the name of the option. This also decides the corresponding variable name. For example, if the option name is `cm-threshold`, then you can specify `--cm-threshold=0.5` or `cm-threshold=0.5` on the command line, and the value will be stored inside a variable named `cm_threshold`. The option-name to variable conversion is as follows (Yes, there might be conflicts if you use consecutive dashes and dots):
  - A single dash is converted to one underscore `_`.
  - A single dot is converted to three understores `___`.

`<default-value>` is the default value.

`<description>` is the help string regarding this option. It will be automatically added to the help message.

`opt` commands must be used inside a function named `setupArgs()`, which should be defined in the script. An example:

```zsh
#!/usr/bin/env zsh
desc="Example of argument parsing"

setupArgs() {
  opt -r opt-1 '' "First Option"
}

main() {
  info "opt-1 = $opt_1"
}

source "${0:a:h}/deps/hjzscript/go" # where this library is stored
```

`./scriptname.zsh` will give an error, but `./scriptname.zsh --opt-1=5`, `./scriptname.zsh opt-1=5`, or `./scriptname.zsh 5` will assign 5 to `$opt_1`.

### Need-to-run Check

You can optionally implement a `check()` function to indicate whether this script really need to run. Returning 0 from this function means what it's designed to do is already done / in the desired state, and there's no need to run anything. Returning 1 from this function means it's not done yet, and there's need to run this script. If there's no such function, it's always assumed that there's need to run this script.

If there's no need to run the script, it will exit without actually running the main function, unless `--force` is specified on the command line.

When a special option `--check` is specified, the script will return the return value of `check()` (or return 1 if there no such function) without running anything. `--force` has no effect here.
