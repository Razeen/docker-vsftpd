FROM camunda-ci1:5000/debian:stable

RUN echo "deb http://http.debian.net/debian stable main" > /etc/apt/sources.list && \
    rm -rf /etc/apt/sources.list.d/* && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends vsftpd db-util openssl && \
    apt-get clean && \
    rm -rf /var/cache/* /var/lib/apt/lists/* && \
    mkdir -p /var/run/vsftpd/empty && \
    useradd -d /srv/ftp virtual && \
    chown virtual:virtual /srv/ftp && \
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -subj "/C=DE/ST=Berlin/L=Berlin/O=camunda/OU=camunda/CN=camunda-ci0" -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem

ADD bin/start-vsftpd.sh /usr/local/bin/
ADD etc/pam.d/ftp /etc/pam.d/
ADD etc/vsftpd.conf /etc/

EXPOSE 20 21

CMD /usr/local/bin/start-vsftpd.sh
