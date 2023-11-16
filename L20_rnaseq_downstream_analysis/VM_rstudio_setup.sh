### Create Instance

Container 
	Deploy container
		Configure container

- Container image
"ghcr.io/lescai-teaching/rstudio-docker-amd64:latest"

#https://github.com/lescai-teaching/rstudio-docker/pkgs/container/rstudio-docker-amd64


- Environment variables
	+ADD VARIABLE
		DISABLE_AUTH 
		"true"

- Volume mounts
	Add a volume mount
		New volume mount
		
        Volume type	
        "directory"


Mount path 
"/home/rstudio/data"

Host path
"/home/mariangela_santorsola/data"

Mode
"Read/Write"


Boot Disk

Default Operating System
Size
"100GB"



Advanced Options

Networking
#tag name
"rstudio-server" #and press enter


When the VM is running:

- Copy the "External IP"

- Paste "External IP" on browser as follows:
"External IP":8787


To check if the docker is running, on the VM SSH terminal:

```
docker ps
```

#Create new firewall

VPC Network
	Firewall

CREATE FIREWALL RULE


NAME
	"rstudio-port"

Action on match
	Targets
			"rstudio-server"


Protocols and ports
	TCP
	"8787"

CREATE



