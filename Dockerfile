FROM ubuntu:22.04
ARG userid
ARG groupid
ARG username

RUN apt update && apt-get install -y bison build-essential curl flex git gnat libncurses5-dev m4 zlib1g-dev uuid-dev nasm imagemagick python2 python3 pkg-config libpci-dev zlib1g-dev libssl-dev -y

RUN groupadd -g $groupid $username \
 && useradd -m -u $userid -g $groupid $username \
 && echo $username >/root/username
# && echo "export USER="$username >>/home/$username/.gitconfig
ADD files /prep
# COPY gitconfig /home/$username/.gitconfig
# RUN chown $userid:$groupid /home/$username/.gitconfig
ENV HOME=/home/$username
ENV USER=$username
RUN ln -sf /usr/bin/python2 /usr/bin/python && mv /prep/prepX220 /usr/bin/prepX220 && chmod +x /usr/bin/prepX220

ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -i
