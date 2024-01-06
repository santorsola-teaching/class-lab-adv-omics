### Create Instance

### Add container
- Container 
-   Deploy container
- 	  Configure container
-       Container image    
-        ```ghcr.io/lescai-teaching/rstudio-docker-amd64:latest```     

available at  https://github.com/lescai-teaching/rstudio-docker/pkgs/container/rstudio-docker-amd64.   
   

- Environment variables
-     +ADD VARIABLE
-       ```DISABLE_AUTH``` = ```"true"```



### Boot Disk

- Operating System   
-   "cos-101-17162-336-20"    
- Size    
-      ```100GB```   



### Advanced Options

#### Networking  
- Tag name      
- 		```rstudio```

and press enter.


When the VM is running:

- Copy the VM *<External_IP>*
- Paste VM *<External_IP>* on a *browser*, as follows:

```<External_IP>:8787```


or

you can use gcloud tool:

```gcloud compute ssh YOUR-VM-NAME \
    --project=YOUR-PROJECT-NAME \
    --zone=europe-west4-a \
    -- -NL localport:localhost:remoteport

e.g.
localport=12000
remoteport=8787
```

and type on the browser:

```
localhost:12000
```

### MAke sure you have the rstudio firewall rule or create a new one:

- VPC Network   
- 	Firewall   

### CREATE FIREWALL RULE

- NAME   
- 		```rstudio-port```  
 
- Action on match
- 	Targets    
- 		```rstudio```    


- Protocols and ports    
-  	TCP    
-   	```8787```

- CREATE



###### Assignment class 20 #######
Download input data from https://github.com/santorsola-teaching/class-lab-adv-omics-2023/blob/main/L17_rnaseq_running/results.zip and upload to RStudio server.

