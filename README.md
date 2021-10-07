# This text helps you in setting up a developer machine on gcp.
## This should be run once in the gcp project for one vm.
### open google cloud console (make sure right project is selected)
```
$ gcloud config set project <project-id>
$ dev_vm_name=lucky
$ bash <(curl -s https://raw.githubusercontent.com/mandiwal-cloud/gcp/main/project-setup.sh) $dev_vm_name
```

## Below will create a new vm machine
###  open google cloud console (make sure right project is selected)
```
$ gcloud config set project <project-id>
$ dev_vm_name=lucky	
$ wget -O tutorial-dev-machine.sh https://raw.githubusercontent.com/mandiwal-cloud/gcp/main/tutorial-dev-machine.sh

```
### Option 1: create the Virtual Machine (cheapest dev box) without static IP 
```
$ gcloud compute instances create $dev_vm_name \
 --project=$GOOGLE_CLOUD_PROJECT \
 --zone=asia-southeast1-b \
 --machine-type=n1-standard-1 \
 --preemptible \
 --image=ubuntu-1804-bionic-v20210928 \
 --image-project=ubuntu-os-cloud \
 --boot-disk-size=10GB \
 --boot-disk-type=pd-standard \
 --boot-disk-device-name=$dev_vm_name \
 --metadata-from-file startup-script=tutorial-dev-machine.sh \
 --network-tier=STANDARD \
 --subnet=default \
 --tags=http-server,https-server \
 --labels=os=ubuntu-18-04-lts,cost-alloc=tutorials,usage=golang,configuration=v1-1-0 \
 --no-boot-disk-auto-delete
```
### Option 2: create the Virtual Machine with static IP 
- Find the reserved IP address that you have created for that VM and store it in a variable.
```
$ IP_ADDRESS_DEV_MACHINE=$(gcloud compute addresses list \
 --filter="name:$dev_vm_name-ip AND region:asia-southeast1" \
 --format="value(address_range())"
 )
```
- create the Virtual Machine (cheapest dev box) with static ip
```
$ gcloud compute instances create $dev_vm_name \
 --project=$GOOGLE_CLOUD_PROJECT \
 --zone=asia-southeast1-b \
 --machine-type=n1-standard-1 \
 --preemptible \
 --image=ubuntu-1804-bionic-v20210928 \
 --image-project=ubuntu-os-cloud \
 --boot-disk-size=10GB \
 --boot-disk-type=pd-standard \
 --boot-disk-device-name=$dev_vm_name \
 --metadata-from-file startup-script=tutorial-dev-machine.sh \
 --network-tier=STANDARD \
 --address=$IP_ADDRESS_DEV_MACHINE \
 --subnet=default \
 --tags=http-server,https-server \
 --labels=os=ubuntu-18-04-lts,cost-alloc=tutorials,usage=golang,configuration=v1-1-0 \
 --no-boot-disk-auto-delete
```
## setup remote connection by hitting below on local chrome browser
- https://remotedesktop.google.com/headless
## use remote connection by hitting below on local chrome browser
- https://remotedesktop.google.com/access
## delete the instance
###  open google cloud console (make sure right project is selected)
```
$ gcloud config set project <project-id>
$ dev_vm_name=lucky
$ gcloud compute instances delete $dev_vm_name \
 --zone=asia-southeast1-b
 ```

 ## create machine with minikube
 - create instance with 2 cpus and 20gb disk
 ```
$ dev_vm_name=lucky	
$ gcloud compute instances create $dev_vm_name \
 --project=$GOOGLE_CLOUD_PROJECT \
 --zone=asia-southeast1-b \
 --machine-type=n1-standard-2 \
 --preemptible \
 --image=ubuntu-1804-bionic-v20210928 \
 --image-project=ubuntu-os-cloud \
 --boot-disk-size=20GB \
 --boot-disk-type=pd-standard \
 --boot-disk-device-name=$dev_vm_name \
 --metadata-from-file startup-script=tutorial-dev-machine.sh \
 --network-tier=STANDARD \
 --address=$IP_ADDRESS_DEV_MACHINE \
 --subnet=default \
 --tags=http-server,https-server \
 --labels=os=ubuntu-18-04-lts,cost-alloc=tutorials,usage=golang,configuration=v1-1-0 \
 --no-boot-disk-auto-delete
 ```
 - ssh to the box
 - run all the steps from the below script manually on the box (script is not working but indivudual steps are working)
 - https://raw.githubusercontent.com/mandiwal-cloud/gcp/main/install-docker-k8s.sh
 
 ## create machine with minikube second time if above machine was deleted (disk was not deleted when vm was deleted)
 ```
$ dev_vm_name=lucky	
$ gcloud compute instances create $dev_vm_name \
 --project=$GOOGLE_CLOUD_PROJECT \
 --zone=asia-southeast1-b \
 --machine-type=n1-standard-2 \
 --preemptible \
 --image=ubuntu-1804-bionic-v20210928 \
 --image-project=ubuntu-os-cloud \
 --boot-disk-size=20GB \
 --boot-disk-type=pd-standard \
 --boot-disk-device-name=$dev_vm_name \
 --metadata-from-file startup-script=tutorial-dev-machine.sh \
 --network-tier=STANDARD \
 --address=$IP_ADDRESS_DEV_MACHINE \
 --subnet=default \
 --tags=http-server,https-server \
 --labels=os=ubuntu-18-04-lts,cost-alloc=tutorials,usage=golang,configuration=v1-1-0 \
 --no-boot-disk-auto-delete
 ```
 - ssh to the box and run below command
 ```
minikube start
 ```
