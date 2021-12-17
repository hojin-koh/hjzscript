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

# Basic flow of a single script

HJZ_BEGIN_DATE="$(date +'%Y-%m-%d %H:%M:%S')"
__HJZ::FLOW::prescript() {
  if [[ -n "${logfile-}" ]]; then
    setupLog "$logfile" "$logrotate"
  fi

  if [[ -n "${hjzCommandLineOriginal-}" ]]; then
    info "Begin $hjzCommandLineOriginal"
  else
    info "Begin $ZSH_ARGZERO $@"
  fi
  info "$HJZ_BEGIN_DATE (SHLVL=$SHLVL)"
}

run() {
  __HJZ::FLOW::prescript "$@"
  main "$@"
}

TRAPEXIT() {
  info "End $ZSH_ARGZERO ($?)"
}

TRAPINT() {
  warn "Killed"
  exit 130
}
