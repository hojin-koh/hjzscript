#!/usr/bin/env zsh
desc="Test argument parsing"

setupArgs() {
  opt -r rslt '' "Check Result"
}

check() {
  if [[ "$rslt" == true ]]; then
    return 0
  else
    return 1
  fi
}

main() {
  info RUN
}

source "${0:a:h}/../../go"
