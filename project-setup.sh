#!/bin/sh

# this should be run once in the gcp project.


dev_vm_name=$1

# Reserve a static IP address for that machine
gcloud compute addresses create $dev_vm_name-ip --project=$GOOGLE_CLOUD_PROJECT --network-tier=STANDARD --region=asia-southeast1

# Create Firewall rules to access the VM
gcloud compute firewall-rules create allow-http \
 --project=$GOOGLE_CLOUD_PROJECT \
 --direction=INGRESS \
 --network=default \
 --action=ALLOW \
 --rules=tcp:80 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=http-server 


# allow access from secure http connections. The Chrome Remote Desktop we use to connect to the machine needs port 443 open.
gcloud compute firewall-rules create allow-https \
 --project=$GOOGLE_CLOUD_PROJECT \
 --direction=INGRESS \
 --network=default \
 --action=ALLOW \
 --rules=tcp:443 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=https-server

