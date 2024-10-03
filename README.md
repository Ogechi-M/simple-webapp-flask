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
