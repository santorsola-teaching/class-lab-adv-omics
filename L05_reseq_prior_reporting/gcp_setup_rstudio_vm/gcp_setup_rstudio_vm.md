# nf-core/sarek - reporting



## Set your working place

- Create your rstudio VM instance from Google Cloud Console.

Follow instructions in this [video](https://drive.google.com/file/d/1Fr699ynIeNNq73MMeoUT19DVkglPRv-o/view?usp=drive_link)

You need to mount the docker from [here](https://github.com/lescai-teaching/rstudio-docker/pkgs/container/rstudio-docker-amd64)

Navigate to Container -> Deploy Container

1. Container image: ``` ghcr.io/lescai-teaching/rstudio-docker-amd64:latest ``` 

2. Add variable -> Name: ```DISABLE_AUTH``` /  value: ```true```


## Open RStudio:

Copy the *External IP* of the created VM

Open a new Browser window

paste: 
```
<External IP>:8787
```


IMPORTANT: Loading the RStudio interface can take some time.

