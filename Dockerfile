FROM ubuntu:latest
COPY functions/ /home/root/functions/
COPY update.sh /home/root/update.sh
COPY show.sh /home/root/show.sh
# COPY show.sh /home/root/show.sh
# RUN apk add bash
CMD ["/bin/bash"]