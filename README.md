

Table of Contents
==================

- [Table of Contents](#table-of-contents)
- [Wow Such Program](#wow-such-program)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [Build and Run](#build-and-run)
  - [Tools \& Technologies used 🛠](#tools--technologies-used-)
  - [Fix json struct fields not exported bug](#fix-json-struct-fields-not-exported-bug)
  - [Docker file key highlights](#docker-file-key-highlights)
  - [Docker compose file](#docker-compose-file)
  - [Jenkins workflow](#jenkins-workflow)
  - [Helm charts](#helm-charts)
  - [Argocd](#argocd)


# Wow Such Program 
## Description 


This program is very simple, it connects to a MySQL database based on the following env vars:
* MYSQL_HOST
* MYSQL_USER
* MYSQL_PASS
* MYSQL_PORT

And exposes itself on port 9090:
* On `/healthcheck` it returns an OK message, 
* On GET it returns all recorded rows.
* On POST it creates a new row.
* On PATCH it updates the creation date of the row with the same ID as the one specified in query parameter `id`

## Prerequisites

- [install go](https://golang.org/doc/install)
- [install mysql](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-fresh-install)
- [(Optional) install docker](https://docs.docker.com/engine/install/)
- [(Optional) install jenkins](https://www.jenkins.io/doc/book/installing/)
- [(Optional) install minikube](https://minikube.sigs.k8s.io/docs/start/)
- [install argocd](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- Clone the repo on your machine
```bash
git clone https://github.com/abdalla-abdelsalam/internship-challenge
```

## Build and Run 

After setting the environment variables that is required for mysql connection follow these steps:
- build the project

```bash
    go build -o app .
```

- Run the project

```bash
    ./app
```


- (Optional) if you prefer docker-compose

```bash
    docker-compose up -d
```
## Tools & Technologies used 🛠
* Go programming language
* mysql
* Docker
* Jenkins 
* Kubernetes
* argocd

## Fix json struct fields not exported bug
Struct fields must start with a capital letter to translate them to json

![bug](https://github.com/abdalla-abdelsalam/internship-challenge/assets/51873396/6aec031e-e483-459a-b850-b1d0503ee64e)


## Docker file key highlights
* It uses golang:1.17-alpine as a minimal base image
* Copy the Go modules files first before copying the rest of the source code to enable caching of dependencies
* Use multi-stage technique to reduce the size of the image and also increase the security of the image 
* Create a non-root user with a specific UID to run the container as non-root user to increase the security of the image
* Sleep for a while until the database is fully initialized then run the application
  
## Docker compose file
* Build the local image using the docker file
* Set the required env variables for the image
* Get mysql image and set the required env variables

## Jenkins workflow
1. Checkout github repo
2. Build the docker image using dockerfile
3. Push the Image to Dockerhub
4. Remove Unused docker image
5. All the previous steps will report if any error happens
<div style="width: 800px">

![jenkins workflow](https://github.com/abdalla-abdelsalam/internship-challenge/assets/51873396/f37f25ed-c941-4cd1-96f9-5d0910eb31c9)
</div>
6. send the status of the build via email

<div style="width: 800px">

![sending email](https://github.com/abdalla-abdelsalam/internship-challenge/assets/51873396/97a95db3-1172-4360-aa64-3776280e1074)

</div>

## Helm charts
To deploy the charts to k8s run the following command:
```bash
helm install RELEASE_NAME ./helm-charts
```

* mysql manifests will be deployed first to initialize the database, it include:
  * pv
  * pvc
  * service
  * secret
  * statefulset
* app manifests include:
  * deployment
  * Horizontal Pod Autoscaler
  * secret
  * service

## Argocd
after installing argocd server into the cluster you can deploy argocd configfile to the cluster:

```bash
    kubectl apply -f ./argocd/argocd.yaml
```
make it accessable to the public with port forwarding
```bash
    kubectl port-forward -n argocd svc/argocd-server 7070:443
```
<div style="width: 800px">

![argocd](https://github.com/abdalla-abdelsalam/internship-challenge/assets/51873396/fa676983-5e62-4818-9e5b-696294b8301a)
</div>