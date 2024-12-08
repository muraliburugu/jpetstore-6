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

FROM openjdk:17.0.2

# Set the working directory in the container
WORKDIR /usr/src/myapp

# Copy the entire project into the container
COPY . .

# Make the mvnw file executable and build the project
RUN chmod +x ./mvnw && ./mvnw clean package

# Expose port 8080 if it's a web application
EXPOSE 8080

# Start the application with cargo:run for Tomcat
CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]

