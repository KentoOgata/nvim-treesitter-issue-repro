FROM docker.io/ubuntu:23.04

RUN apt-get update &&\
        apt-get install -y software-properties-common &&\
        add-apt-repository ppa:neovim-ppa/unstable &&\
        apt-get update &&\
        apt-get install -y\
        neovim=0.10.0~ubuntu1+git202308301604-bec13cfca-9b397864c-0bcf73b55~ubuntu23.04.1\
        git\
        build-essential

ARG REMOTE=https://github.com/nvim-treesitter/nvim-treesitter.git
ARG LOCAL=/root/.local/share/nvim/site/pack/github.com/start/nvim-treesitter
ARG REV=920b37260ebc720b0399bd12954fd2bf8bd18242

RUN git clone ${REMOTE} ${LOCAL} &&\
        git -C ${LOCAL} checkout ${REV}

COPY ["./init.lua", "/root/.config/nvim/init.lua"]

ENTRYPOINT ["nvim"]
