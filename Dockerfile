FROM docker.io/ubuntu:23.04

ARG HOME=/root
ARG CONFIG=${HOME}/.config/nvim
ARG DATA=${HOME}/.local/share/nvim
ARG GIT_URL=https://github.com/nvim-treesitter/nvim-treesitter.git
ARG PLUGIN_PATH=${DATA}/site/pack/github.com/start/nvim-treesitter
ARG REV=920b37260ebc720b0399bd12954fd2bf8bd18242
ARG NVIM_VERSION=0.10.0~ubuntu1+git202308301604-bec13cfca-9b397864c-0bcf73b55~ubuntu23.04.1

RUN apt-get update &&\
        apt-get install -y software-properties-common &&\
        add-apt-repository ppa:neovim-ppa/unstable &&\
        apt-get update &&\
        apt-get install -y\
        neovim=${NVIM_VERSION}\
        git\
        build-essential

RUN git clone ${GIT_URL} ${PLUGIN_PATH} &&\
        git -C ${PLUGIN_PATH} checkout ${REV}

COPY ["./init.lua", "${CONFIG}/init.lua"]

ENTRYPOINT ["nvim"]
