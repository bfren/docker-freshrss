# Docker FreshRSS

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freshrss) ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/freshrss?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/freshrss/latest?label=size)<br/>
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-freshrss/dev?label=build)

[Docker Repository](https://hub.docker.com/r/bfren/freshrss) - [bfren ecosystem](https://github.com/bfren/docker)

Comes with [FreshRSS](https://freshrss.org/) preinstalled, along with all the required and recommended PHP modules.

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

## Licence

> [MIT](https://mit.bfren.uk/2021)

## Copyright

> Copyright (c) 2021 bfren.uk
