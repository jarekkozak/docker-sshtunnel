# Docker-sshtunnel
Docker image based on ubuntu 16.04 for easy port tunneling.

# Tunnel

This is a ssh-tunnel container for easy configure and start ssh tunnels in order to connect to remote servers.
This tunnel uses its own ssh setup so do not need to do anything on your local machine. There is only requirements you have to have an access to the remote machine and enouch rights to establish ssh link.

Connection is done using `autossh`. 


# Usage

For simple usage just clone this git repository run command 
```
./build.sh
```
and run container 
```
docker run -d -p 8080:80 \
	-e PASS=password \
	-e HOST=user@example.com \
	-e REMOTE_PORTS=80 \
	--name ssh-tunnel jarek/sshtunnelimage
```
Execute above command will create ssh tunnel to `example.com` using `user` credentials. Next port `80` from `example.com` will be forwarded to the running container. In addition forwarded port will be ezposed on your local machine using `8080` port.

You can link just created containers to the other and internaly remote host can be accessed like `ssh-tunnel:80` (unless you change linked container name, please see docker documentation).

You can map multiple ports at the same time 
```
docker run -d -p 8080:80 -p 5432:5432 \
	-e PASS=password \
	-e HOST=user@example.com \
	-e REMOTE_PORTS=80;5432 \
	--name ssh-tunnel jarek/sshtunnelimage
```
In this case two ports `80` and `5432` will be tunneled and exposed. Exposing port to local machine is not mandatory.

For quick start two files are provided `config` and `run-tunnel.sh` just edit `config` and run `run-tunnel.sh`.

#Important 

What is happeninig behind the scene. During container instantiation keys pair will be generated in `/keys` directory (inside container) and  `id_rtsa.pub` key is copiend to `/home/user/.ssh/known_host` on remote machine.

Each time you instatiane a new container a new keys are generated and copied to the remote machine. It could make mess in `known_host` file. 
To avoid such situation you can generate your own keys (please see ssh documentation how to do it) and put them in any dir and run command

```
docker run -d -p 8080:80 \
  -v your-dir-absolute-path=/keys \
	-e HOST=user@example.com \
	-e REMOTE_PORTS=80 \
	--name ssh-tunnel jarek/sshtunnelimage
```
Do not forget copy your `id_rsa.pub` to `~/.ssh/known_host` file to enable passwordless ssh login. You do not have to provide password.

You can add keys on build phase. In this case put your keys in `docker-sshtunnel/src/keys` directory. 
