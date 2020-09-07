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

FROM ubuntu:20.04

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  tzdata

RUN export DEBIAN_FRONTEND=noninteractive && \
  ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
#RUN sudo apt-get install -y texlive texlive-xetex
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Standard tools
RUN apt-get update && apt-get install -y --no-install-recommends  \
	man vim neovim screen tree tig git curl wget bc less ctags \
  python python3 python3-dev python3-pip \
	sudo git bash-completion cscope \
	ca-certificates \
	figlet \
	ssh \
	zsh \
	gnupg \
	fd-find \
	file \
	build-essential automake libtool gcc gdb cmake \
	clang-format clang-tidy clang-tools clang clangd llvm-10 \
	libc6-dev \
	manpages-posix-dev \
	libssl-dev \
	libfuse3-dev

# Create user
RUN useradd -m -s /bin/bash -p '*' wonderfly
RUN echo "wonderfly ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/wonderfly && \
    chmod 0440 /etc/sudoers.d/wonderfly
RUN chown -R wonderfly: /home/wonderfly
USER wonderfly

# Settings for $USER that are hard to do elsewhere
ENV LANG=C.UTF-8
RUN export TERM=xterm-256color
RUN sudo chsh -s $(which zsh) wonderfly
ENV ASAN_SYMBOLIZER_PATH "/usr/lib/llvm-10/bin/llvm-symbolizer"

# Go.
RUN mkdir -p /tmp/go/
RUN curl -L -o /tmp/go/go.tar.gz https://golang.org/dl/go1.15.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xzf /tmp/go/go.tar.gz && rm -r /tmp/go
ENV PATH "$PATH:/usr/local/go/bin"

# Non-standard tools

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/wonderfly/.fzf
RUN /home/wonderfly/.fzf/install

# ripgrep
WORKDIR /home/wonderfly
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
RUN sudo dpkg -i ripgrep_0.10.0_amd64.deb

# coderay
RUN git clone https://github.com/rubychan/coderay.git /home/wonderfly/coderay

# Linux Man Pages: https://www.kernel.org/doc/man-pages/
RUN wget -O /tmp/man-pages-5.04.tar.xz https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-5.04.tar.xz
RUN cd /tmp/ && tar xf man-pages-5.04.tar.xz
RUN cd /tmp/man-pages-5.04/ && sudo make install && \
    rm -rf /tmp/man-pages-5.04 /tmp/man-pages-5.04.tar.xz

# Oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Python packages
RUN pip3 install autopep8
RUN pip3 install pynvim neovim
ENV PATH "/home/wonderfly/.local/bin/:$PATH"

# diff-so-fancy
RUN git clone https://github.com/so-fancy/diff-so-fancy /home/wonderfly/diff-so-fancy
ENV PATH "/home/wonderfly/diff-so-fancy/:$PATH"

# aerc
RUN sudo apt-get install scdoc
RUN git -C /tmp/ clone https://git.sr.ht/\~sircmpwn/aerc
RUN sudo PATH="$PATH":/usr/local/go/bin/ make -C /tmp/aerc install && \
    rm -r /tmp/aerc

# Set up dotfiles and vim
COPY --chown=wonderfly . /home/wonderfly/.dotfiles
ENV PATH "/home/wonderfly/.dotfiles/third_party/rcm/bin:$PATH"
RUN rcup -f
RUN vim +PlugInstall +qall
RUN cp /home/wonderfly/.dotfiles/mymuse.zsh-theme /home/wonderfly/.oh-my-zsh/custom/themes/

# Now, unminimize the "minimized" Ubuntu
RUN yes | sudo unminimize

CMD [ "zsh" ]
