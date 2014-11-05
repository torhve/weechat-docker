# To run
# sudo docker run --net=host -i -t -v=/home/xt/weechat:/home/xt/.weechat -v /etc/localtime:/etc/localtime:ro torhve/weechat


FROM ubuntu:14.04
MAINTAINER Tor Hveem <tor@hveem.no>
RUN apt-get -qq update
RUN apt-get -y build-dep weechat

RUN apt-get -y install git
RUN git clone https://github.com/weechat/weechat.git
RUN mkdir weechat/build
RUN cd weechat/build && cmake .. -DCMAKE_BUILD_TYPE=Debug && make && make install

# Add support for emoji
ADD wcwidth.c wcwidth.c
RUN gcc -shared -fPIC -Dmk_wcwidth=wcwidth -Dmk_wcswidth=wcswidth -o libwcwidth.so wcwidth.c

ENV LD_PRELOAD /libwcwidth.so

# Fix locale
RUN locale-gen en_US.UTF-8

RUN useradd xt
RUN mkdir -p /home/xt
RUN chown -R xt:xt /home/xt
USER xt
ENV HOME /home/xt
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV C en_US.UTF-8
ENV TERM screen-256color
ENTRYPOINT weechat-curses
