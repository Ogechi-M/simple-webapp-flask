# Project Description

This is a simple web application using [Python Flask](http://flask.pocoo.org/) and [MySQL](https://www.mysql.com/) database. 
This is used in the demonstration of the development of Ansible Playbooks. The app is containerized using Docker, and the deployment process is automated via a CI/CD pipeline that pushes the Docker image to Docker Hub and deploys it to a Kubernetes cluster.

# Prerequisites

**Python 3.x** - Python is required to run this application locally.

**Docker** - Docker is used to containerize the application and run it locally.

**Git** - To clone repositories and manage source code.

**KinD** - KinD is used to run Kubernetes clusters locally in Docker containers.

**Kubectl** - kubectl is the command-line tool used to interact with the Kubernetes cluster.

**VS code** - VS Code is recommended as your development environment.


# Run Flask Webapp Locally

  
  Below are the steps required to get this working on a base linux system.
  
  - **Install all required dependencies**
  - **Install and Configure Web Server**
  - **Start Web Server**
   
## 1. Install all required dependencies
  
  Python and its dependencies
  ```bash
  apt-get install -y python3 python3-setuptools python3-dev build-essential python3-pip default-libmysqlclient-dev
  ```
   
## 2. Install and Configure Web Server

Install Python Flask dependency
```bash
pip3 install flask
pip3 install flask-mysql
```

- Copy `app.py` or download it from a source repository
- Configure database credentials and parameters 

## 3. Start Web Server

Start web server
```bash
FLASK_APP=app.py flask run --host=0.0.0.0
```

## 4. Test

Open a browser and go to URL
```
http://<IP>:5000                            => Welcome
http://<IP>:5000/how%20are%20you            => I am good, how about you?
```

# How to Containerize Flask Webapp

The following steps shows how the API was containerized using Docker.

## 1. Build a Docker Image

Using the Dockerfile provided, build a Docker image by running the following command:

```bash
docker build -t <image-name> .
```

## 2. Push image to Dockerhub

To push your image to DockerHub, run the following command:
```bash
docker tag <image-name> <dockerhub-username>/<repo-name>:<tag>
```

```bash
docker push <image-name> <dockerhub-username>/<repo-name>:<tag>
```

## Pull image from Dockerhub

Pull your docker image from Dockerhub using the following command:
```bash
docker pull <image-name> <dockerhub-username>/<repo-name>:<tag>
```

## Containerizing Flask Webapp

```bash
docker run -p 5000:5000 <dockerhub-username>/<repo-name>:<tag>
```

# Understanding the CI/CD Process

# Deploying Flask Webapp to Kubernetes(KinD)

# Security Measures Implemented

The following security measures were implemented in the process of building this project.

- Using a minimal base image in Dockerfile ubuntu:20.04

- The Docker image was scanned for vulnerabilities using Trivy

- Updated the docker file to enhance security and set the environmental variables for non interactive installation. The apt install command cleans up unnecessary files after installation.

- Set resource limits in kubernetes to help avoid resource exaustion and malicious attacks such as Denial of service (DOS).

- Implemented network policies in the kubernetes manifest file to restrict traffics between pods and also to control which pods can communicate with each other.
