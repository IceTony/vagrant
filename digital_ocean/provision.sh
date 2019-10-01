# Add second 100gb disk to droplet and mount it to /srv/data
apt update -y && apt install curl -y &&
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $1" -d '{"size_gigabytes":100, "name": "'$HOSTNAME'-volume", "description": "Block store for examples", "region": "nyc1"}' "https://api.digitalocean.com/v2/volumes" &&
droplet_id=$(curl http://169.254.169.254/metadata/v1/id) &&
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $1" -d '{"type": "attach", "volume_name": "'$HOSTNAME'-volume", "region": "nyc1", "droplet_id": "'"$droplet_id"'" }' "https://api.digitalocean.com/v2/volumes/actions" &&
echo - - - > /sys/class/scsi_host/host*/scan || true &&
sleep 5
/sbin/parted /dev/sda mklabel gpt --script &&
/sbin/parted /dev/sda mkpart primary 0% 100% --script &&
sleep 5
mkfs.ext4 /dev/sda1 &&
mkdir -p /srv/data &&
echo "/dev/sda1 /srv/data ext4 auto 0 2" >> /etc/fstab &&
mount -a
