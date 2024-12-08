#
#    Copyright 2010-2023 the original author or authors.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#       https://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

- name: docker build and push
  hosts: 172.31.27.123  # Replace with the hostname or IP address of your target server
  become: yes  # Run tasks with sudo privileges

  tasks:
    - name: Update apt package cache
      apt:
        update_cache: yes   

    - name: Build Docker Image
      command: docker build -t petstore .
      args:
        chdir: /var/lib/jenkins/workspace/petstore

    - name: tag image
      command: docker tag petstore:latest muraliburugu507/petstore:latest 

    - name: Log in to Docker Hub
      community.docker.docker_login:
        registry_url: https://index.docker.io/v1/
        username: dockerhub username
        password: dockerhub password/PAT

    - name: Push image
      command: docker push muraliburugu507/petstore:latest

    - name: Run container
      command: docker run -d --name pet1 -p 8081:8080 muraliburugu507/petstore:latest
