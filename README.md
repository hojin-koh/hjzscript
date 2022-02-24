# hjzscript

Hojin's zsh scripting framework

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
[I-0000.0] Begin ./scriptname.zsh
[I-0000.0] 2021-09-20 14:09:59 (SHLVL=5)
The main script goes here
[I-0000.0] End ./scriptname.zsh
```

The main added functionalities of this library are:
- Opinionated colorful messages
- Command-line parsing
- Logging
- Pre/post-script hooks
- Temp directory management

## Colorful messages

`debug` command output text into log file only, not on screen

`info` command outputs bright white info messages with a timestamp, just like the example in the **Basics** section.

`warn` command outputs yellow warning text with a timestamp

`err` command outputs red error message with a timestamp, and exits with specified error code

`prompt` command asks user a question, and stores the reply in `$REPLY` variable

`promptyn` command asks user a yes/no question, and stores the reply in `$REPLY` variable

## Command-line

TODO
