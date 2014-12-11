build:
	docker build -t camunda/vsftpd .

run:
	docker run --rm --name ftp --net=host -v /tmp/ftp:/srv/ftp camunda/vsftpd

daemon:
	docker run -d --name ftp --net=host -v /tmp/ftp:/srv/ftp camunda/vsftpd

debug:
	docker run --rm --name ftp --net=host -v /tmp/ftp:/srv/ftp -it camunda/vsftpd /bin/bash

kill:
	docker rm -f ftp
