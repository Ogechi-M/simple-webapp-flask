# Use an official Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages: python3, pip3
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Flask using pip
RUN pip3 install flask

# Copy the application files
COPY app.py /opt/

# Create a non-root user and switch to it
RUN useradd -m flaskuser
USER flaskuser

# Set the working directory (optional, for better organization)
WORKDIR /opt

# Set the environment variable for Flask
ENV FLASK_APP=app.py

# Expose the port the Flask app runs on
EXPOSE 8080

# Run the Flask application
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]

