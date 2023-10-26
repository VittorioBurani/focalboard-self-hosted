# Focalboard Self Hosted

Docker network to selfhost [mattermost/focalboard](https://github.com/mattermost/focalboard) following the resorces in [this page](https://www.focalboard.com/docs/personal-edition/ubuntu/).

The network is compsed by two Docker containers:

- Ubuntu 22.04 running focalboard and nginx
- PostgreSQL database

It's possible to configure Postgres and host machine IP address and serving port through `.env` file.
