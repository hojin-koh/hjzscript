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
  export PATH="${HJZ_ROOT_DIR}/bin:$PATH"
fi

source "${0:a:h}/lib/flow.zsh"
source "${0:a:h}/lib/opts.zsh"
source "${0:a:h}/lib/msg.zsh"
source "${0:a:h}/lib/logging.zsh"
