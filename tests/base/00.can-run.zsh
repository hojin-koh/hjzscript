#!/usr/bin/env zsh
desc="Test if a simple script can be run"

main() {
  debug "$desc"
  info "$desc"
  warn "$desc"
}

source "${0:a:h}/../../go"
