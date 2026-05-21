# This repository contains a containerized infrastructure using Docker, featuring WordPress, MariaDB, an HTTP echo service, and an Nginx reverse proxy. The environment is secured with a strict `iptables` firewall setup.

## 🏗 Architecture & Networking

The infrastructure is divided into two isolated networks to ensure security and proper communication flows:
**`backend-net`**: A private network strictly for communication between the WordPress application and the MariaDB database.
**`frontend-net`**: A public-facing network handling communication between the Nginx reverse proxy, the WordPress container, and the `http-echo` service.

**Data Persistence:**
State is maintained across reboots using dedicated Docker volumes:
`db_data`: Persists the MariaDB database files.
`wp_data`: Persists the WordPress installation and configuration files.

## 📁 Project Structure

`compose.yaml`: Docker Compose configuration file for declarative deployment.
`deploy.sh`: Bash script to deploy the environment using standalone `docker run` commands.
`cleanup.sh`: Script to stop and remove containers and networks, preserving data volumes.
`purge.sh`: Script to completely destroy the environment, including persistent volumes, for a fresh start.
`firewall.sh`: Bash script configuring `iptables` to secure the host.
`default.conf`: Nginx reverse proxy configuration routing traffic to the appropriate containers.
`.env`: Environment variables for database credentials.
`.gitignore`: Ensures sensitive files like `.env` are not committed to version control.

## 🚀 Getting Started

### 1. Prerequisites
Ensure the host machine (virtual server) has the following installed:
Docker
`iptables-persistent` (for saving firewall rules across reboots)

### 2. Environment Configuration
Create a `.env` file in the root directory of the project with your database credentials:

```env
MYSQL_ROOT_PASSWORD=example
MYSQL_DATABASE=example
MYSQL_USER=example
MYSQL_PASSWORD=example
```
### 3. Deployment
You can deploy the infrastructure using one of two methods:
- **Method A**: Using Docker Compose
```Bash
docker compose up -d
```
- **Method B**: Using the Bash Script
```Bash
chmod +x deploy.sh
./deploy.sh
```
### 4. Firewall & Security
The server is secured using iptables with a default DROP policy. Only strictly necessary traffic is permitted:
Port 22 (TCP): SSH Access.
Port 80 (TCP): Nginx Reverse Proxy routing to WordPress.
Port 7878 (TCP): Nginx Reverse Proxy routing to http-echo.

All other services are completely hidden from the outside host. Apply and save the firewall rules to persist automatically on reboot:
```Bash
chmod +x firewall.sh
sudo ./firewall.sh
```

### 🌐 Accessing the Services
Once deployed and with the firewall active, you can access the services from your local host machine:
**WordPress**: Navigate to http://192.168.99.10.
**HTTP-Echo**: Navigate to http://192.168.99.10:7878 to see the "Bienvenido" message.

### 🧹 Lifecycle Management
To stop and remove the containers while keeping your data intact (simulating a soft reset):
```Bash
chmod +x cleanup.sh
./cleanup.sh
```

To completely wipe the environment, including all persistent data, allowing you to configure the application from scratch:
```Bash
chmod +x purge.sh
./purge.sh
```

