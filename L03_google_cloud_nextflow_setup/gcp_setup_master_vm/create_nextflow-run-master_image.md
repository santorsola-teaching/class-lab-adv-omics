# Create the nextflow-run-master image

- Create the [VM](https://github.com/santorsola-teaching/class-lab-adv-omics/tree/main/L03_google_cloud_nextflow_setup/gcp_setup_master_vm) named e.g.,  ```sarek-master```


- Stop the VM to ensure the image captures a consistent disk state.
Click on the name of your VM that is now terminated, scroll down to the Storage disks section and note the name of the Boot disk.

- Navigate to Compute Engine -> Images

- Click the CREATE IMAGE button

- Fill out the Image Details: 

1. Name: ``` nextflow-run-master ```

2. Source disk: ```sarek-master```

3. Image family (Optional, but Recommended): Enter a family name (e.g., ```labos-25-26-series```) 

- Click CREATE

The new image will appear in the Images list in a few minutes

- Delete the original VM

See also this [video](https://www.youtube.com/watch?v=AA7Dpyjic64&t=330s)


