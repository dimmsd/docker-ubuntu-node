[![Build Status](https://travis-ci.org/dimmsd/docker-ubuntu-node.svg?branch=master)](https://travis-ci.org/dimmsd/docker-ubuntu-node)
## Nodejs docker image

Ubuntu + nvm + nodejs

Based on images:

[Ubuntu base image](https://github.com/dimmsd/docker-ubuntu-base)

### Using the `Makefile`

```
$ make help
config-test			Test docker-compose.yml
up				Up services
down				Down services
logs				Show container logs
exec-node			Attach to NODE container and start bash session
check-version			Check version docker images (up services before!)
check-demo			Execute for test nodejs demo application
install-node			Install Nodejs
install-demo			Install node modules for demo application
```

### Example demo

```
$ git clone git://github.com/dimmsd/docker-ubuntu-node.git
$ cd docker-ubuntu-node
$ cp .env.example .env
$ make build
$ make install-node
$ make install-demo
$ make up
## Check running demo application
$ make check-demo
## Add example.loc in your /etc/hosts, see Environment section
## Go example.loc:3000 in your browser
```

### Environment

See `.env.example` for detail

Default domain is example.loc (variable MAIN_DOMAIN)

Default IP Httpd service in `.env.example` is 172.50.0.100

For testing example.loc from host system, add host name in `/etc/hosts` file

`172.50.0.100 example.loc www.example.loc`

Bash script for run background node application - `./utils/node-service.bash`

### Run Docker commands without sudo

See this [section](https://github.com/dimmsd/docker-ubuntu-base#run-docker-commands-without-sudo).