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
FG_default=$(tput sgr0)
FG_red=$(tput setaf 1)
FG_green=$(tput setaf 2)
FG_purple=$(tput setaf 5)
FG_orange=$(tput setaf 9)

## Less colors for man pages
export PAGER=less
# Begin blinking
export LESS_TERMCAP_mb=$FG_red
# Begin bold
export LESS_TERMCAP_md=$FG_orange
# End mode
export LESS_TERMCAP_me=$FG_default
# End standout-mode
export LESS_TERMCAP_se=$FG_default
# Begin standout-mode - info box
export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 7)
# End underline
export LESS_TERMCAP_ue=$FG_default
# Begin underline
export LESS_TERMCAP_us=$FG_green
