###############################################
## system installation steps ##################
###############################################

# CentOS Stream 9 x86/64
# Each time you spin up a new VM, 
# you'll need to manually install the following tools 
# to ensure your environment is properly set up:



sudo yum install -y git
sudo yum install -y java-11-openjdk-devel

sudo yum install -y epel-release
sudo yum install -y screen


## only after these tools are installed
## you can install nextflow as well

export NXF_VER=24.04.4
export NXF_MODE=google


# create the nfbin directory
mkdir nfbin

# go to the nfbin directory
cd nfbin

# download nextflow
curl https://get.nextflow.io | bash

# navigate back to your $HOME directory
cd ..

# set the `PATH` environment variable
export PATH=${PATH}:${PWD}/nfbin/

#e.g. export PATH=${PATH}:/home/<YOUR_HOME_FOLDER>/nfbin/

echo 'export PATH=${PATH}:${PWD}/nfbin/' >> ~/.bashrc


### the following assumes the credentials have been previously saved
### in a key with a name of your choice


export GOOGLE_APPLICATION_CREDENTIALS=/home/$(whoami)/<YOUR-PRIVATE-JSON-KEY>


echo 'export GOOGLE_APPLICATION_CREDENTIALS=/home/$(whoami)/<YOUR-PRIVATE-JSON-KEY>' >> ~/.bashrc




