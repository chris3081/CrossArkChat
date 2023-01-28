FROM ubuntu:focal

ENV TZ=Australia/Brisbane
RUN apt update && apt install -y libunwind-dev libicu-dev wget unzip
RUN adduser crossark; mkdir /app; chown crossark:crossark /app
RUN  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER crossark
ENV USER=crossark HOME=/home/crossark

RUN cd /; wget https://github.com/spikeydragoon/Cross-Ark-Chat/files/5556890/CrossArkChatLinux.zip -O /tmp/CrossArkChatLinux.zip; \
    unzip /tmp/CrossArkChatLinux.zip -d /app ; \
    rm /tmp/CrossArkChatLinux.zip; \
    chmod 755 /app/CrossArkChatLinux/CrossArkChat; \
    chown crossark:crossark /app


WORKDIR /app/CrossArkChatLinux

USER crossark

VOLUME [ '/app/CrossArkChatLinux/Config' ]

CMD ["./CrossArkChat"]
