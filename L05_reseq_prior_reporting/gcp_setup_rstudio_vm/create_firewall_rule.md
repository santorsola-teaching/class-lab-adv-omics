# Create the rstudio firewall rule

- Navigate to VPC Network -> Firewall

- Click the CREATE FIREWALL RULE button

- Fill out the Firewall Rule Details: 

1. Name: ``` rstudio-server ```

2. Target tags: ```rstudio```

3. Source IPv4 ranges: ```0.0.0.0/0```) 

4. Tick TCP -> Ports: ``8787```)

- Click CREATE

The new firewall rule will appear in the list in a few minutes


