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
docker run -p 80:8080 <dockerhub-username>/<repo-name>:<tag>
```

# Understanding the CI/CD Process

 In general, The pipeline automates testing, building, and deploying your Flask app to a Kubernetes cluster. 

 Here is a break down of the different stages of the CI/CD pileline:

## Build Job

This job handles building and pushing the Docker image.

### Step 1. Checkout Code:

- This uses the actions/checkout@v3 GitHub Action to fetch the source code from my GitHub repository into the runner (a virtual machine that GitHub Actions provides for this pipeline).

 ### Step 2. Log in to Docker Hub:

- This command logs in to Docker Hub using credentials my username and password that are securely stored in GitHub Secrets.
- The credentials are passed into the command using echo and docker login.

### Step 3. Build Docker Image:

- This step runs docker build to create a Docker image from flask web application using the Dockerfile in the root of my repository.
- It tags the image using the current commit hash (${{ github.sha }}) to ensure that each image is unique and can be traced back to the exact code.

### Step 4. Push Docker Image:

- After the image is built, it’s pushed to Docker Hub under my account using the same commit hash as the tag.
- This makes the image publicly available for the deployment stage later on.

## Test Job 

This job tests the code to ensure it works as expected by running unit tests.

### Step 1. Checkout Code:

- Similar to the build job, this step fetches the repository code.

### Step 2. Setup Python

- This uses actions/setup-python@v3 to install Python in the virtual environment so you can run your Flask app and tests.
- The version is set to 3.x, which will install the latest available version of Python 3.x.

### Step 3. Install Dependences

- This step installs all the required Python packages listed in the requirements.txt file, ensuring the app has everything it needs to run.
- It installs packages like Flask, pytest, etc.

### Step 4. Run Tests

- This step runs all unit tests located in the tests directory using the unittest framework.
- The command python3 -m unittest discover -s tests searches for all test files and runs them.
- If any of the tests fail, this job will fail, and the deploy job will not be triggered.

## Deploy Job

This job handles deploying your Flask app to a Kubernetes cluster using the kubectl tool.

### Step 1. Checkout Code

- Like the previous jobs, it checks out the repository code.

### Step 2. Set up kubectl:

- This step uses azure/setup-kubectl@v3 to set up the kubectl command-line tool, which is used to interact with the Kubernetes cluster.
- It installs the latest version of kubectl so it can be used it to apply the Kubernetes manifest.

### Step 3. Deploy to Kubernetes:

- This command runs kubectl apply -f kubernetes-manifest.yaml, which reads the Kubernetes manifest file and deploys the application to the Kubernetes cluster.
- The environment variable KUBECONFIG is securely stored in GitHub Secrets and contains the credentials and configuration needed to access your Kubernetes cluster.

For the purpose of integrating security into DevOps practices, The Test job depends on the success of the Build job to run and also the Delopoy job depends on the success of the Build and Test jobs to run

# Deploying Flask Webapp to Kubernetes(KinD)

Follow the following steps to deploy the API to kubernetes.

## 1. Create a Kubernetes Cluster with KinD

To run the application in Kubernetes, you need to set up a local cluster using KinD:

### a. Create the cluster:

```bash
kind create cluster --name flask-app-cluster
```

### b. Verify the cluster is running:

```bash
kubectl cluster-info --context kind-flask-app-cluster
```

## 2. Apply Kubernetes Manifest

The Kubernetes manifest file (k8s-manifest.yaml) defines the deployment and service for the Flask app. It deploys the app using the Docker image you created and exposed it using a NodePort service.

```bash
kubectl apply -f k8s-manifest.yaml
```

## 3. Access the Flask App

After deploying, you can check the service for the NodePort:

```bash
kubectl get services
```

Once you have the NodePort, access the Flask app in your browser at:

```bash
http://localhost:30000
```

# Security Measures Implemented

The following security measures were implemented in the process of building this project.


- Used a trusted base image for the Dockerfile Ubuntu:20.04
  
- The Docker image was scanned for vulnerabilities using Trivy.

- Updated the docker file to enhance security and set the environmental variables for non interactive installation. The apt install command cleans up unnecessary files after installation.

- Set resource limits in kubernetes to help avoid resource exaustion and malicious attacks such as Denial of service (DOS).

- Limited the containers privillage using securitycontext by setting the container to run as non root in the kubernetes manifest.

- Implemented network policies in the kubernetes manifest file to restrict traffics between pods and also to control which pods can communicate with each other.

- In the CI/CD pipeline, a test job was included to test the code to ensure it works as expected by running unit tests.

- Also only runs sucessfully if all the jobs where successful.
