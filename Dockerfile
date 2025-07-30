FROM ubuntu:latest
COPY docker/ /home/root/docker
COPY git/configure_git.sh /home/root/git/configure_git.sh
COPY functions/ /home/root/functions/
COPY update.sh /home/root/update.sh
# COPY show.sh /home/root/show.sh
# RUN apk add bash
CMD ["/bin/bash"]