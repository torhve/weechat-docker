WeeChat Docker
=============


This dockerfiler compiles weechat from source with debug flags.
It embeds wcwidth lib to enable full UTF-8 support in ncurses/glibc.
You are supposed to have your weechat directory outside the container 
and share it from the host filesystem.
Network is used directly on the host to simplify binding ports and using different addresses.


Building
========

    sudo docker build -t="torhve/weechat" .

Running
=======

    sudo docker run --net=host -i -t -v=/home/xt/weechat:/home/xt/.weechat -v /etc/localtime:/etc/localtime:ro torhve/weechat
