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

# Option-related functions

hjzHelpMessage="$desc"$'\n'$'\n'
hjzOpts=()
hjzRequiredArgs=()

opt() {
  local required=false
  if [[ "${1-}" == "-r" ]]; then
    required=true
    shift
  fi
  local name="$1"
  local nameVar="${name//-/_}"
  local nameVar="${nameVar//./___}"
  local value="$2"
  local desc="$3"
  hjzOpts+=( "$nameVar" )
  if [[ "$required" == true ]]; then
    hjzHelpMessage+="  $name=$value"$'\t'"$desc"$'\n'
    hjzRequiredArgs+=( "$nameVar" )
  else
    hjzHelpMessage+="  [--]$name=$value"$'\t'"$desc"$'\n'
  fi
  if [[ "$value" == "("* ]]; then
    declare -ga "$nameVar"
    eval "$nameVar=$value"
  else
    declare -g "$nameVar"
    eval "$nameVar='$value'"
  fi
}

HJZ::FLOW::checkRequiredArgs() {
  for var in "${(@)hjzRequiredArgs}"; do
    if [[ -z "${(P)var-}" ]]; then
      err "Required argument $var not specified" 1
    fi
  done
}

HJZ::HOOK::logOptions() {
  for var in "${(@)hjzOpts}"; do
    if [[ "${(Pt)var-}" == "array" ]]; then
      debug "option:$var=(${(P@)var-})"
    else
      debug "option:$var=${(P)var-}"
    fi
  done
}
addHook exit HJZ::HOOK::logOptions
