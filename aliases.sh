#!/usr/bin/zsh

function create_drogon_dir_structure() {

  if [[ -z "${SERVICES_FOLDER}" ]]; then
    echo "Need to define SERVICES_FOLDER env variable"
    return 0
  fi

  if [[ -z "${DOWNLOADS_FOLDER}" ]]; then
    echo "Need to define DOWNLOADS_FOLDER env variable"
    return 0
  fi

  all_services=(sonarr radarr ombi portainer
                portainer tautulli_data netdata
                grafana influx_data prometheus_data
                prometheus sabnzbd ombi plex grocy
                redis_data hydra2 jacket qbittorrent)
  for t in ${all_services[@]}; do
    echo creating ${SERVICES_FOLDER}/${t}
    mkdir -p ${SERVICES_FOLDER}/${t}
  done

  mkdir -p ${DOWNLOADS_FOLDER}/.incomplete/sabnzbd
  mkdir -p ${DOWNLOADS_FOLDER}/.incomplete/qbittorrent
  mkdir -p ${DOWNLOADS_FOLDER}/completed/torrent
  mkdir -p ${DOWNLOADS_FOLDER}/completed/newznab
  # must have exa
  ls -laT $DOWNLOADS_FOLDER
}

# dstack <monitoring|infra> <env_file>
function stack_up() {
  local stack_name=$1
  local env=$2

  # while getopts ':su:' arg; do
  #   case $arg in
  #     s) print got s; s=sss;;
  #     u) print got u;;
  #     # \*) print nothing: $OPTARG; usage;;
  #     # \?) print invalid option: $OPTARG; usage;;
  #   esac
  # done
  echo "starting stack ${stack_name} with ${env}.env"
  env $(cat .envs/${env}.env) docker stack deploy -c "${stack_name}/stack.yml" $stack_name
}

function drogon_down() {
  docker stack rm infra
  docker stack rm monitoring
  docker stack rm managers
  docker stack rm indexers
  docker stack rm downloaders
  docker stack rm frontends
}

function drogon_up() {
  stack_up infra drogon
  stack_up monitoring drogon
  stack_up managers drogon
  stack_up indexers drogon
  stack_up downloaders drogon
  stack_up frontends drogon
}
