#!/usr/bin/env zsh
desc="Test argument parsing"

setupArgs() {
  opt -r opt-1 '' "First Option (Mandatory)"
  opt opt-2 '' "Second Option"
  opt opt.3 '' "Third Option"
}

main() {
  test "$opt_1" -eq 15
  test "$opt_2" -eq 16
  test "$opt___3" -eq 17
}

source "${0:a:h}/../../go"
