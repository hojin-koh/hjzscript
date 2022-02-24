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

The main added functionalities are:
- command-line parsing
- logging
- opinionated colorful messages
- pre/post-script hooks
- temp directory management

## Command-line

TODO
