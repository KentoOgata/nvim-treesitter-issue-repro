FROM docker.io/ubuntu:23.04

RUN apt-get update &&\
        apt-get install -y software-properties-common &&\
        add-apt-repository ppa:neovim-ppa/unstable &&\
        apt-get update &&\
        apt-get install -y\
        neovim=0.10.0~ubuntu1+git202308301604-bec13cfca-9b397864c-0bcf73b55~ubuntu23.04.1\
        git\
        build-essential

COPY ["./init.vim", "/root/.config/nvim/init.vim"]

ENTRYPOINT ["nvim"]
