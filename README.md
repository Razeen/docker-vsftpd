# docker vsftpd

## Run

```
docker run -d --name ftp --net=host -v /tmp/ftp:/srv/ftp camunda/vsftp
```

## Available environment variables

- `FTP_USERNAME`: username of ftp user (default: razeen)
- `FTP_PASSWORD`: password of ftp user (default: razeen)
