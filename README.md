```markdown
# N-to-N Load Balancing Scenario with Vagrant & Docker

This project demonstrates an N-to-N load balancing architecture using **Vagrant**, **VirtualBox**, **Nginx**, and **Docker**. It provisions two virtual machines to simulate a distributed environment where a load balancer distributes incoming traffic across multiple backend containers.

## Architecture Overview

- **Node 1 (Load Balancer)**:
  - IP Address: `192.168.56.10`
  - Role: Runs Nginx as a reverse proxy and load balancer.
  - Configuration: Distributes traffic using the Round-Robin algorithm to the backend servers.

- **Node 2 (Application/Backend Server)**:
  - IP Address: `192.168.56.11`
  - Role: Hosts multiple Docker containers running a simple web server (`nginxdemos/hello`).
  - Containers: `web1` (port 8081), `web2` (port 8082), `web3` (port 8083) -> (N=3)

## Prerequisites

Before running this project, ensure you have the following installed on your host machine:
- VirtualBox
- Vagrant

## Getting Started

### 1. Provision the Virtual Machines
Clone this repository and navigate to the project directory, then run:
```bash
vagrant up
```

### 2. Setup Node 2 (Backend & Docker)
SSH into Node 2 and run the automated setup script to install Docker and spin up the containers:
```bash
vagrant ssh node2
bash /vagrant/setup-node2.sh
```
*Note: This script installs Docker, adds the `vagrant` user to the Docker group, and launches 3 web containers.*

### 3. Setup Node 1 (Load Balancer)
SSH into Node 1, copy the Nginx configuration file from the shared folder, and restart the service:
```bash
vagrant ssh node1
sudo cp /vagrant/nginx.conf /etc/nginx/sites-available/default
sudo systemctl restart nginx
```

## Testing the Load Balancer

To verify that the Nginx load balancer is correctly distributing the traffic among the 3 backend containers, run the following command inside **Node 1**:

```bash
for i in {1..6}; do curl -s http://localhost | grep "Server name"; echo "---"; done
```

You should see the Server name (Container ID) changing with each request, indicating that the Round-Robin mechanism is working perfectly.

## Author
[Ehsan]
```