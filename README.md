# Docker FreshRSS

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freshrss) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Ffreshrss) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Ffreshrss) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-freshrss/dev.yml?branch=main)

[Docker Repository](https://hub.docker.com/r/bfren/freshrss) - [bfren ecosystem](https://github.com/bfren/docker)

Comes with [FreshRSS](https://freshrss.org/) preinstalled, along with all the required and recommended PHP 8.2 modules.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Licence / Copyright](#licence)

## Ports

* 80

## Volumes

| Volume   | Purpose                             |
| -------- | ----------------------------------- |
| `/data`  | Persistent storage for config, etc. |

See the [Nginx](https://github.com/bfren/docker-nginx) image for other configuration details.

## Environment Variables

See the [Nginx + PHP](https://github.com/bfren/docker-nginx-php) image for details of `www.conf` and `php.ini` overrides using environment variables.

| Variable             | Values | Description                                | Default           |
| -------------------- | ------ | ------------------------------------------ | ----------------- |
| `FRESHRSS_BASE_URL`  | string | External URL used to access this instance. | *None* - required |
| `FRESHRSS_USER_NAME` | string | Default user name.                         | *None* - required |
| `FRESHRSS_USER_PASS` | string | Default user password.                     | *None* - required |
| `FRESHRSS_DB_HOST`   | string | Database host.                             | *None* - required |
| `FRESHRSS_DB_USER`   | string | Database username.                         | *None* - required |
| `FRESHRSS_DB_PASS`   | string | Database password.                         | *None* - required |
| `FRESHRSS_DB_NAME`   | string | Database table name.                       | *None* - required |

## Licence

> [MIT](https://mit.bfren.dev/2021)

## Copyright

> Copyright (c) 2021-2023 [bfren](https://bfren.dev) (unless otherwise stated)
