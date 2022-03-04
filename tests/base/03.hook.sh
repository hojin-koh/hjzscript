#!/usr/bin/env zsh
desc="Test argument parsing"

ACCUM=()

setupArgs() {
  ACCUM+=( "setupArgs" )
  addHook preparse preparse1
  addHook preparse preparse2
  addHook preparse preparse0 begin
  addHook postparse postparse1
  addHook prescript prescript1
}

preparse1() {
  ACCUM+=( "preparse1" )
}
preparse2() {
  ACCUM+=( "preparse2" )
}
preparse0() {
  ACCUM+=( "preparse0" )
}

postparse1() {
  ACCUM+=( "postparse1" )
}

check() {
  ACCUM+=( "check" )
  return 1
}

prescript1() {
  ACCUM+=( "prescript1" )
}

main() {
  info "${ACCUM[*]}"
  test "${ACCUM[1]}" '==' "setupArgs"
  test "${ACCUM[2]}" '==' "preparse0"
  test "${ACCUM[3]}" '==' "preparse1"
  test "${ACCUM[4]}" '==' "preparse2"
  test "${ACCUM[5]}" '==' "postparse1"
  test "${ACCUM[6]}" '==' "check"
  test "${ACCUM[7]}" '==' "prescript1"
}

source "${0:a:h}/../../go"
