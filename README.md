# sshd-alpine-rdkit
alpine linux with sshd and rdkit

## example
```
docker run -d --name sshd-alpine-rdkit -p 8022:22 yamasakih/sshd-alpine-rdkit
```
You can change 8022 to other port number.

Then, you can connect virtual environment with SSH.

```
ssh root@localhost -p 8022
```

Default root password is root.

## Docker Hub
https://hub.docker.com/r/yamasakih/sshd-alpine-rdkit/

