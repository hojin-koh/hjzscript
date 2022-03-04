#!/usr/bin/env zsh
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

# The central include file

set -o err_return
set -o no_unset
set -o pipefail

# Open file descriptor 5 (show only, no logging) if not yet done
if [[ ! -e /dev/fd/5 ]]; then
  exec 5>&2
fi

# Open file descriptor 6 (logging only, no show) if not yet done
# This is default value, may be overriden by log files later
if [[ ! -e /dev/fd/6 ]]; then
  exec 6>/dev/null
fi

# Setup path for our executables
if [[ -z "${HJZ_ROOT_DIR-}" ]]; then
  export HJZ_ROOT_DIR="${0:a:h}"
fi

source "${0:a:h}/lib/flow.zsh"
source "${0:a:h}/lib/opts.zsh"
source "${0:a:h}/lib/msg.zsh"
source "${0:a:h}/lib/logging.zsh"
source "${0:a:h}/lib/fs.zsh"

opt check false "Check whether this script need to run (return false=need)"
opt force false "Always run the script even if there's no need"

if declare -f setupArgs >/dev/null; then
  setupArgs
fi
HJZ::FLOW::preparse "$@"
source "${0:a:h}/bin/parseopts"
HJZ::FLOW::postparse "$@"

hjzNeedToRun=true
if declare -f check >/dev/null; then
  check && hjzNeedToRun=false || hjzNeedToRun=true
fi

if [[ "$check" == "true" ]]; then
  unset -f TRAPEXIT
  if [[ "$hjzNeedToRun" == "true" ]]; then
    exit 1
  fi
  exit 0
else
  if [[ "$hjzNeedToRun" == "true" || "$force" == "true" ]]; then
    HJZ::FLOW::prescript "$@"
    main "$@"
  else
    info "Check passed, no need to run $hjzCommandLineOriginal"
  fi
fi
