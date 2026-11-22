# FreshRSS

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freshrss) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Ffreshrss) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Ffreshrss) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-freshrss/build.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/freshrss) - [Quay.io](https://quay.io/repository/bfren/freshrss) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

[FreshRSS](https://freshrss.org) - a self-hosted RSS and Atom feed reader - installed and set up automatically.

It is [Nginx + PHP](https://github.com/bfren/docker-nginx-php) (PHP 8.5) with:

* FreshRSS 1.30.4 installed, read-only, outside your volume - so upgrading means pulling a new image
* the PHP extensions FreshRSS requires, including SQLite, MySQL and PostgreSQL drivers
* automatic installation on first start, using environment variables - no set-up wizard
* feeds refreshed every 15 minutes

It is designed to run behind a reverse proxy that handles SSL, such as [Caddy Proxy](https://github.com/bfren/docker-caddy-proxy).

## Quickstart

`docker-compose.yml`, with a [MariaDB](https://github.com/bfren/docker-mariadb) database:

```yaml
services:
  freshrss:
    image: quay.io/bfren/freshrss:6.0
    restart: unless-stopped
    depends_on:
      db:
        condition: service_healthy
    environment:
      - BF_FR_BASE_URL=https://rss.example.com
      - BF_FR_USER_NAME=ben
      - BF_FR_USER_PASS=${FR_PASSWORD}
      - BF_FR_DB_HOST=db
      - BF_FR_DB_USER=freshrss
      - BF_FR_DB_PASS=${DB_PASSWORD}
    ports:
      - "8080:80"
    volumes:
      - ./v/data:/data

  db:
    image: quay.io/bfren/mariadb:mariadb11.8-10.0
    restart: unless-stopped
    environment:
      - BF_DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
      - BF_DB_APPLICATION=freshrss
      - BF_DB_PASSWORD=${DB_PASSWORD}
    volumes:
      - ./v/db:/data
```

This example is also in [`docker-compose.yml`](docker-compose.yml).

`.env` (keep it out of version control):

```sh
FR_PASSWORD=change-me
DB_ROOT_PASSWORD=change-me-root
DB_PASSWORD=change-me-too
```

1. Change the passwords in `.env`. FreshRSS and MariaDB both read `DB_PASSWORD`, so the database password only needs setting once.
2. Run `docker compose up -d`. FreshRSS waits until MariaDB is healthy, because the installation needs the database. Then FreshRSS is installed, using the database `freshrss`, and your user is created.
3. Open `http://localhost:8080` and log in.

The environment variables are only used on that first start - after that, change settings in FreshRSS.

To use SQLite instead of a database server, leave out the `db` service, `depends_on` and the `BF_FR_DB_*` variables, and set `BF_FR_DB_TYPE=sqlite`. The database is then kept in `/data`.

## Features

* 📰 FreshRSS, ready to use on first start
* 🗄️ MySQL / MariaDB (default), PostgreSQL or SQLite
* ⏱️ Feeds refreshed every 15 minutes by cron
* 🔒 FreshRSS's own updater turned off - updates come with the image
* 🗜️ Everything from [Nginx + PHP](https://github.com/bfren/docker-nginx-php#features): PHP-FPM, OPcache, compression, logs and a health check

## Tags

Images are published to Docker Hub (`bfren/freshrss`) and Quay.io (`quay.io/bfren/freshrss`) for `linux/amd64`, `linux/arm/v7` and `linux/arm64`. There is one build, on PHP 8.5.

| Tag                                        | Example                     | Use when                                   |
| ------------------------------------------ | --------------------------- | ------------------------------------------ |
| `latest`                                   |                             | You always want the newest image           |
| `MAJOR`                                    | `6`                         | You want updates, but not breaking changes |
| `MINOR`                                    | `6.0`                       | You want fixes only - **recommended**      |
| `VERSION`                                  | `6.0.5`                     | You want to pin this image exactly         |
| `freshrssA`, `freshrssA.B`                 | `freshrss1`, `freshrss1.30` | You want to stay on a FreshRSS version     |
| `freshrssA.B.C`                            | `freshrss1.30.4`            | You want an exact FreshRSS release         |
| `freshrssA-VERSION`, `freshrssA.B-VERSION` | `freshrss1.30-6.0.5`        | You want to pin both                       |

A new `MAJOR` version means a breaking change. Before moving to one, read the [changelog](CHANGELOG.md), where each breaking change is marked **Breaking**.

## Configuration

### Ports

| Port | Purpose                                            |
| ---- | -------------------------------------------------- |
| `80` | HTTP - put a reverse proxy in front of it for SSL. |

### Volumes

| Volume  | Purpose                                                                                        |
| ------- | ---------------------------------------------------------------------------------------------- |
| `/data` | FreshRSS's data - `config.php`, users, caches, and the database if you use SQLite. Back it up. |

### Environment Variables

These are used **only on first start**, to install FreshRSS. After that, change settings in FreshRSS itself.

| Variable            | Values                      | Description                                                                         | Default      |
| ------------------- | --------------------------- | ----------------------------------------------------------------------------------- | ------------ |
| `BF_FR_BASE_URL`    | URL                         | **Required.** The address you use to open FreshRSS, e.g. `https://rss.example.com`. | *blank*      |
| `BF_FR_USER_NAME`   | text                        | **Required.** The first user's name.                                                | *blank*      |
| `BF_FR_USER_PASS`   | text                        | **Required.** The first user's password.                                            | *blank*      |
| `BF_FR_DB_TYPE`     | `mysql`, `pgsql`, `sqlite`  | Database type.                                                                      | `mysql`      |
| `BF_FR_DB_HOST`     | host name                   | Database server - not needed for SQLite.                                            | *blank*      |
| `BF_FR_DB_USER`     | text                        | Database user - not needed for SQLite.                                              | *blank*      |
| `BF_FR_DB_PASS`     | text                        | Database password - not needed for SQLite.                                          | *blank*      |
| `BF_FR_DB_NAME`     | text                        | Database name.                                                                      | `freshrss`   |
| `BF_FR_DB_PREFIX`   | text                        | Table prefix - an underscore is added (e.g. `fr_`).                                 | `fr`         |
| `BF_FR_LANGUAGE`    | e.g. `en`, `fr`, `de`       | Default language.                                                                   | `en`         |
| `BF_FR_ENVIRONMENT` | `production`, `development` | `development` gives more detailed logging.                                          | `production` |

[Nginx + PHP](https://github.com/bfren/docker-nginx-php#environment-variables) adds the PHP settings, and [Nginx](https://github.com/bfren/docker-nginx#environment-variables) the nginx ones.

## How It Works

### Starting

When the container starts, [Nginx + PHP](https://github.com/bfren/docker-nginx-php#starting) sets up nginx and PHP, then this image:

1. serves FreshRSS's `p` (public) folder instead of `/www/public`, and links FreshRSS's `data` folder to `/data`
2. if `/data/config.php` exists, treats FreshRSS as installed and does nothing more
3. otherwise installs it with FreshRSS's command-line tools: prepares the data folders, sets up the database, creates your user and fetches their feeds

If the installation fails, the container stops - check `docker logs` for the reason.

### Refreshing feeds

Every 15 minutes, cron runs `fr-actualize`, which runs FreshRSS's `actualize_script.php` to fetch new articles for every user. You can run it yourself:

```sh
docker exec <container> fr-actualize
```

## Testing

```sh
./test.nu        # builds the image and runs /test
```

`/test` runs this image's tests alongside the base images' tests, and fails if tests don't execute. They check how the first user's name and password are read (including the older `BF_FR_USER` / `BF_FR_PASS` names), that installation is recorded, that FreshRSS matches the version in the build log, the required PHP extensions are loaded, and nginx accepts the configuration.

## Troubleshooting

### The container stops on first start

The installation failed. The usual causes are a missing `BF_FR_BASE_URL`, `BF_FR_USER_NAME` or `BF_FR_USER_PASS`, or a database that can't be reached - check `docker logs` and fix the variables. If `/data/config.php` was created before it failed, empty `/data` (and the database) before starting again - otherwise FreshRSS will be treated as installed.

### I changed an environment variable but nothing happened

The variables are only used on first start. Change the setting in FreshRSS instead, or (to start completely afresh) empty `/data` and the database.

## FAQs

### Can I use SQLite instead of a database server?

Yes - set `BF_FR_DB_TYPE=sqlite` before the first start. The database is then kept in `/data`.

### How do I update FreshRSS?

Pull a newer tag and recreate the container. FreshRSS's own updater is turned off, because FreshRSS is read-only inside the image.

## Licence

> [MIT](https://mit.bfren.dev/2021)

## Copyright

> Copyright (c) 2021-2026 [bfren](https://bfren.dev) (unless otherwise stated)
