#!/usr/bin/env zsh
desc="The test runner"

main() {
  ./00.can-run.zsh
  ! ./01.args.sh
  ./01.args.sh 15 --opt-2=16 opt.3=17
  ./02.check.sh --check true
  ! ./02.check.sh --check false
  ./02.check.sh --force true
  ./02.check.sh false
  ./03.hook.sh
}

source "${0:a:h}/../../go"
