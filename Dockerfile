FROM ubuntu:14.04.1

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    rm -rf /etc/apt/sources.list.d/* && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends vsftpd db-util && \
    apt-get clean && \
    rm -rf /var/cache/* /var/lib/apt/lists/* && \
    mkdir -p /var/run/vsftpd/empty && \
    useradd -d /srv/ftp virtual && \
    chown virtual:virtual /srv/ftp

ADD bin/start-vsftpd.sh /usr/local/bin/
ADD etc/pam.d/ftp /etc/pam.d/
ADD etc/vsftpd.conf /etc/

CMD /usr/local/bin/start-vsftpd.sh
