docker volume rm $(docker volume ls | awk '{print $2}' | sed -e '/^.\{,60\}$/d')