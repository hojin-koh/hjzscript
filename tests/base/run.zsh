#!/usr/bin/env zsh
desc="The test runner"

main() {
  ./00.can-run.zsh
  if ! ./01.args.sh; then
    true
  fi
  ./01.args.sh 15 --opt-2=16 opt.3=17
}

source "${0:a:h}/../../go"
