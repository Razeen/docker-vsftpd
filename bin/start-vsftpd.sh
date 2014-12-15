#!/bin/bash

FTP_USERNAME=${FTP_USERNAME:-camunda}
FTP_PASSWORD=${FTP_PASSWORD:-camunda}

PASS_DB=/etc/vsftpd_login.db

rm -rf $PASS_DB
echo -e "${FTP_USERNAME}\n${FTP_PASSWORD}" | db_load -T -t hash $PASS_DB

chown -R virtual:virtual /srv/ftp

service vsftpd start

exec tail -f /var/log/vsftpd.log
