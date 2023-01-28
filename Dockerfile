FROM ubuntu:focal

RUN apt update && apt install -y libunwind-dev libicu-dev wget unzip
RUN adduser crossark; mkdir /app; chown crossark:crossark /app

USER crossark
ENV USER=crossark HOME=/home/crossark
ENV TIMEZONE=Australia/Brisbane

RUN cd /; wget https://github.com/spikeydragoon/Cross-Ark-Chat/files/5556890/CrossArkChatLinux.zip -O /tmp/CrossArkChatLinux.zip; \
    unzip /tmp/CrossArkChatLinux.zip -d /app ; \
    rm /tmp/CrossArkChatLinux.zip; \
    chmod 755 /app/CrossArkChatLinux/CrossArkChat; \
    chown crossark:crossark /app; \
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone

WORKDIR /app/CrossArkChatLinux

USER crossark

VOLUME [ '/app/CrossArkChatLinux/Config' ]

CMD ["./CrossArkChat"]
