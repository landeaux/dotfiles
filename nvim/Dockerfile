FROM ubuntu:22.10

WORKDIR /neovim

RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  apt-transport-https \
  ca-certificates \
  && update-ca-certificates

RUN apt-get install -y \
  ninja-build \
  gettext \
  libtool-bin \
  cmake \
  g++ \
  pkg-config \
  unzip \
  curl

RUN git clone https://github.com/neovim/neovim .

ARG VERSION=v0.9.0
RUN git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install

RUN apt-get install -y --no-install-recommends \
  fd-find \
  gzip \
  nodejs \
  npm \
  ripgrep \
  wget \
  xclip \
  python3.10-venv

RUN npm install --global tree-sitter-cli

WORKDIR /root/.config/nvim

# COPY . .

CMD [ "/bin/bash" ]
