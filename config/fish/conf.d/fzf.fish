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

if test -d "$HOMEBREW_HOME/opt/fzf"
  set -x FZF_HOME "$HOMEBREW_HOME/opt/fzf"
end

if test -z "$FZF_HOME" && test -d $HOME/.fzf
  set -x FZF_HOME $HOME/.fzf
end

if test -n "$FZF_HOME"
  set -x PATH "$FZF_HOME/bin:$PATH"
end

# General fzf settings.
set -x FZF_DEFAULT_OPTS " \
  --inline-info \
  --reverse \
  --exact \
  --color=fg+:#F8F8F8,bg+:#515559,pointer:#F8F8F8,marker:226 \
  --bind=ctrl-e:select-all+accept \
  --bind=ctrl-d:half-page-down \
  --bind=ctrl-e:half-page-up
  --bind=ctrl-t:toggle+down
  --bind=ctrl-b:toggle+up
  --bind=ctrl-g:select-all+accept \
  "
