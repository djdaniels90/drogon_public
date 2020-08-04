Documents kind of outdated, cleaning them up is a ticket.  deployment is the 'master' branch not master

# Requirements
Docker Stacks
Docker Compsoe v3.7

# Quickstart setup

Edit drogon.env
source ./.envs/drogon.env
source aliases.sh
create_drogon_dir_structure
drogon_up

# Device Configuration

## sysctl.conf

This blurb is out of date, grab it from the system.  There are misc changes to optimize file watchers,
netdev max budget for 10G networking, etc.

```
net.core.netdev_max_backlog = 10000
net.core.netdev_budget = 1000
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc = fq_codel
vm.max_map_count = 262144
```

# TODOS

## Fix User and deployment location
 - once i figure out the basics i need to
    - move this out of /root/ (probably to user/docker or something)
    - delete all service folders ./services/*
    - and setup a pgid and puid user to run the pool on.
- get volumes all sorted right now everything is dumped into services
however i dont know what to do delete or not to delete upon resets.  Right now its pretty much all related to
to the monitoring stack that i need to be careful will.  Possibly use a mix of volumes and file mounts etc

# Network Map

Services involed include:
  a - cloudflare-ddns (dyn-dns)
