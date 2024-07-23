#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 75s;

echo -e "${ADMIN_PASSWORD}\n${ADMIN_PASSWORD}" | docker-compose exec -T web bash -c "python3 manage.py changepassword admin"
# echo "sync-exercises"
# docker-compose exec -T web bash -c "python3 manage.py sync-exercises" >> /dev/null 2>&1
# echo "download-exercise-images"
# docker-compose exec -T web bash -c "python3 manage.py download-exercise-images" >> /dev/null 2>&1
# echo "download-exercise-videos"
# docker-compose exec -T web bash -c "python3 manage.py download-exercise-videos" >> /dev/null 2>&1

# echo "load-online-fixtures"
# docker-compose exec -T web bash -c "wger load-online-fixtures" >> /dev/null 2>&1
# # afterwards:
# echo "sync-ingredients"
# docker-compose exec -T web bash -c "python3 manage.py sync-ingredients" >> /dev/null 2>&1

# sleep 10s;

# docker-compose down;
# sleep 10s;
# docker-compose up -d


# sleep 75s;
