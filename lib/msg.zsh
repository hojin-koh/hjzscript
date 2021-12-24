# Copyright 2020-2022, Hojin Koh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Message-related functions
typeset -F SECONDS
opt debug false "Whether to show debug messages on screen"

__::outputMessage() {
  local typ="$1"
  local color="$2"
  local msg="$3"
  local nl="${4-\n}"
  local t="$SECONDS"
  printf "\033[%sm[%s-%06.1f] %s\033[m$nl" "$color" "$typ" "$t" "$msg" >&5
  printf "[%s-%06.1f] %s$nl" "$typ" "$t" "$msg" >&6
}

debug() {
  if [[ "${debug-}" == true ]]; then
    printf "\033[0;34m[D-%06.1f] %s\033[m\n" "$SECONDS" "$1" >&2
  else
    printf "[D-%06.1f] %s\n" "$SECONDS" "$1" >&6
  fi
}

info() {
  __::outputMessage I '1;37' "$1"
}

warn() {
  __::outputMessage W '1;33' "$1"
}

err() {
  __::outputMessage E '1;31' "$1"
  if [[ "${2-}" -gt 0 ]]; then
    exit $2
  fi
}

prompt() {
  __::outputMessage P '1;36' "$1: " ''
  read -r REPLY || true
  printf "[%06.1f] REPLY=%s\n" "$SECONDS" "$REPLY" >&6
}

promptyn() {
  __::outputMessage P '1;33' "$1 (y/n): " ''
  read -q REPLY || true
  echo >&5
  printf "[%06.1f] REPLY=%s\n" "$SECONDS" "$REPLY" >&6
}

