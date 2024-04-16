#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 75s;

docker-compose exec -T web bash -c "python3 manage.py sync-exercises"
docker-compose exec -T web bash -c "python3 manage.py download-exercise-images"
docker-compose exec -T web bash -c "python3 manage.py download-exercise-videos"

docker-compose exec -T web bash -c "wger load-online-fixtures"
# afterwards:
docker-compose exec -T web bash -c "python3 manage.py sync-ingredients"

docker-compose down;
docker-compose up -d


sleep 75s;

echo -e "${ADMIN_PASSWORD}\n${ADMIN_PASSWORD}" | docker-compose exec -T web bash -c "python3 manage.py changepassword admin"