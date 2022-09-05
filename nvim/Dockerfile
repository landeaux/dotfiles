FROM alpine:latest

RUN apk --no-cache add \
  autoconf \
  automake \
  build-base \
  cmake \
  ninja \
  coreutils \
  curl \
  gettext-tiny-dev \
  git \
  libtool \
  pkgconf \
  unzip

RUN git clone https://github.com/neovim/neovim.git

ARG VERSION=v0.7.2
RUN cd neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo install

RUN apk update && apk upgrade && apk --no-cache add \
  bash \
  bash-completion \
  ctags \
  fd  \
  gzip \
  nodejs \
  npm \
  ripgrep \
  tree-sitter-cli \
  wget \
  xclip

WORKDIR /root/.config/nvim

COPY . .

CMD [ "/bin/bash" ]
