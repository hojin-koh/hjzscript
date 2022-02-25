#!/usr/bin/env zsh
desc="Test argument parsing"

setupArgs() {
  opt -r opt-1 '' "First Option (Mandatory)"
  opt opt-2 '' "Second Option"
  opt opt.3 '' "Third Option"
}

main() {
  info "opt-1 = $opt_1"
  info "opt-2 = $opt_2"
  info "opt.3 = $opt___3"
}

source "${0:a:h}/../../go"
