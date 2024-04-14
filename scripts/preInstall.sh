#set env vars
set -o allexport; source .env; set +o allexport;

cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_LOGIN=""
SMTP_PASSWORD=""

# Read the file line by line
while IFS= read -r line; do
  # Extract the values after the flags (-e)
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  # Loop through each value and store in respective variables
  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_LOGIN=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    fi
  done <<< "$values"

done < "$filename"

rm post.txt


SECRET_KEY=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 50)
SIGNING_KEY=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 50)

cat << EOT >> ./.env

EMAIL_HOST=tuesday.mxrouting.net
EMAIL_PORT=587
EMAIL_HOST_USER=${SMTP_LOGIN}
EMAIL_HOST_PASSWORD=${SMTP_PASSWORD}
FROM_EMAIL='wger Workout Manager <${SMTP_LOGIN}>'
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