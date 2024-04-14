#set env vars
set -o allexport; source .env; set +o allexport;


SECRET_KEY=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 50)
SIGNING_KEY=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 50)

cat << EOT >> ./.env

SECRET_KEY=${SECRET_KEY}
SIGNING_KEY=${SIGNING_KEY}
EOT


cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 9509,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT