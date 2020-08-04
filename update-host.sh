#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

new_ip=192.168.3.27
file_path=$1

# TODO: would be great to generate this list from the stack.ymls
declare -a services=(
  "cadvisor" "grocy" "qbittorrent" "nextcloud" "transmission" "radarr"
  "sonarr" "traefik" "droppy" "lazylibrary" "grafana" "calibre" "plex"
  "sabnzbd" "deluge" "jackett" "kibana" "hydra2" "organizr" "traefik"
  "tautulli" "netdata" "portainer" "whoami" "openvpn-as" "pihole"
)

# Remove all old lines
sed -i.bak '/######################/d' $file_path
sed -i.bak '/Automatically added by drogon host updater/d' $file_path

# Remove old lines
for service in "${services[@]}"
do
  sed -i.bak "/$service\.knowledgedump\.lan/d" $file_path
  sed -i.bak "/$service\.localhost/d" $file_path
done

echo "############################################" | sudo tee -a $file_path
echo "# Automatically added by drogon host updater" | sudo tee -a $file_path
echo "############################################" | sudo tee -a $file_path

# # TODO append the root domain, this is kinda gross atm so commented out
# sed -i.bak "/knowledgedump\.lan/d" $file_path
# # sed -i.bak "/knowledgedump\.lan/d" $file_path
# echo "$new_ip knowledgedump.lan" | sudo tee -a $file_path

# Add new lines
for service in "${services[@]}"
do
  echo "$new_ip         $service.knowledgedump.lan" | sudo tee -a $file_path
  echo "0.0.0.0             $service.localhost" | sudo tee -a $file_path
done
