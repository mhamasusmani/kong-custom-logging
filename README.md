# Memory Logging Plugin for Kong

## Overview

This repository contains a custom plugin for Kong Gateway (v2.8.x) that enhances logging by capturing and printing:
- Incoming requests (with `<--` to indicate requests coming into Kong).
- Outgoing requests (with `-->` to indicate requests leaving Kong).
- Memory usage in kilobytes for each operation in the format `[memory_used]`.

This plugin is compatible with **Kong 2.8.5** and is designed to be used in conjunction with Kong’s declarative configuration (`kong.yml`).

## Features

- Logs all incoming requests to Kong with a `<--` symbol.
- Logs all outgoing requests from Kong with a `-->` symbol.
- Displays memory usage (in kilobytes) at each request handling step.
- Can be easily deployed within a Kong Docker setup.

## Installation

### Prerequisites

1. **Kong Gateway**: Ensure you have Kong 2.8.5 installed and running.
2. **Git**: Make sure Git is installed on your machine.
3. **Docker**: The plugin is designed to work with Kong deployed using Docker.

### Step 1: Clone the Repository

Clone this repository to your local machine:

git clone https://github.com/mhamasusmani/kong-memory-logging.git
Step 2: Update Kong's Dockerfile
To include this custom plugin in your Kong deployment, you'll need to modify the Dockerfile to copy the plugin files into the appropriate directory inside the Kong container.
1.	Navigate to your Kong installation folder where the Dockerfile is located.
2.	Modify the Dockerfile to copy the plugin into Kong:
Dockerfile

FROM kong:2.8.5

# Add the custom logging plugin
COPY /path-to-your-plugin-directory/kong-memory-logging /usr/local/share/lua/5.1/kong/kong-memory-logging

# Expose necessary ports (Optional)
EXPOSE 8000 8443 8001 8444

# Set environment variables for Kong
ENV KONG_LOG_LEVEL=debug
ENV KONG_PLUGINS=kong-memory-logging

# Run Kong
CMD [ "kong", "docker-start" ]
This Dockerfile does the following:
•	Copies the custom plugin from the kong folder in your repository to Kong’s plugin directory.
•	Sets KONG_LOG_LEVEL=debug to ensure detailed logging.
•	Adds custom-logging-plugin to the list of enabled plugins.
Step 3: Rebuild and Run the Docker Container
Rebuild the Kong Docker container to include the custom logging plugin:
docker build -t my-kong:latest .
docker run -d --name kong-container -p 8000:8000 -p 8443:8443 my-kong:latest
Step 4: Enable the Plugin in kong.yml
In your kong.yml declarative configuration file, enable the plugin for your service or route:
_format_version: "2.1"

services:
  - name: example-service
    url: http://example.com
    routes:
      - name: example-route
        paths:
          - /

plugins:
  - name: kong-memory-logging
    service: example-service
Step 5: Verify the Logs
To verify that the plugin is working correctly, you can check the logs of the running Kong container:
docker logs kong-container
You should see entries like this:
<-- Incoming request: /some-path [Memory usage: 1024.23 KB]
--> Outgoing response: /upstream-path [Memory usage: 2048.56 KB]
Contributing
If you would like to contribute to this project, feel free to submit a pull request with improvements, bug fixes, or new features!
Contact
For any questions or issues, please open an issue in this repository or contact me at Usmani_hamas@live.com.

### Key Points in the README:
- **Overview**: Describes the plugin's purpose and functionality.
- **Installation**: Step-by-step instructions to clone the repo, update the Dockerfile, and run the Kong container.
- **Example Logs**: What to expect when the plugin is running.
- **Contributing**: Standard sections to cover usage and contribution guidelines.
