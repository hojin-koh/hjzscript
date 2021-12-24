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

# Logging-related functions

# Default options
opt logfile '' "Log File"
opt logrotate 3 "Number of old log files to keep"

setupLog() {
  local fname="$1"
  local nRotate="$2"
  # Setup log file: if TRIS_LOGFILE is not empty, then write logs
  if [[ -d "$fname" ]]; then
    err "Cannot log to $fname, it is a directory!" 2
  fi
  if [[ "$nRotate" -gt 0 ]]; then # Do log rotation first if needed
    rotateLog "$fname" "$nRotate"
  fi
  exec 6>"$fname"
  exec 2> >(tee -a /dev/fd/6 >&2)
}

rotateLog() {
  local fname="$1"
  local nRotate="$2"
  if [[ ! -f "$fname" && ! -h "$fname" ]]; then # No need to rotate if no log at all
    return
  fi
  local i
  for (( i=$[nRotate-1]; i>0; i-- )); do
    if [[ -f "$fname.$i.zst" ]]; then
      mv -f "$fname.$i.zst" "$fname.$[i+1].zst"
    fi
  done
  zstd -17 -f -o "$fname.1.zst" --rm "$fname" 2>/dev/null
}

