# Odoo 17 Docker Test Environment

Quick setup to test Odoo 17 addons locally with Docker.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/raphaelh/odoo-docker.git
cd odoo-docker/17.0

# 2. Clone the addon(s) you want to test
mkdir -p addons
git clone --depth 1 -b 17.0 https://github.com/raphaelh/odoo-yavin.git addons/odoo-yavin

# 3. Start
# NOTE: make sure the odoo-yavin/ submodule is up to date!
docker compose up --build -d

# 4. Open http://localhost:8069 and create the database
#    Then activate the addon in Apps (update app list if needed)
```

## Stop

```bash
docker compose down
```

## Test Other Addons

Add more repos in `addons/` and update `odoo.conf` if modules are in subfolders:

```ini
[options]
addons_path = /mnt/extra-addons,/mnt/extra-addons/odoo-yavin,/mnt/extra-addons/other-repo
```

## Structure

```
.
├── docker-compose.yml
├── Dockerfile
├── odoo.conf
├── README.md
└── addons/
    └── odoo-yavin/
        └── pos_yavin/
```
