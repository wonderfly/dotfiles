# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Configure colors for less

## Colors
set -x FG_default (tput sgr0)
set -x FG_red (tput setaf 1)
set -x FG_green (tput setaf 2)
set -x FG_purple (tput setaf 5)
set -x FG_orange (tput setaf 9)

## Less colors for man pages
set -x PAGER less
# Begin blinking
set -x LESS_TERMCAP_mb $FG_red
# Begin bold
set -x LESS_TERMCAP_md $FG_orange
# End mode
set -x LESS_TERMCAP_me $FG_default
# End standout-mode
set -x LESS_TERMCAP_se $FG_default
# Begin standout-mode - info box
set -x LESS_TERMCAP_so (tput bold; tput setaf 0; tput setab 7)
# End underline
set -x LESS_TERMCAP_ue $FG_default
# Begin underline
set -x LESS_TERMCAP_us $FG_green
