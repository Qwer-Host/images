#!/bin/ash
rm -rf /home/container/tmp/*

PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m'

echo "⟳ Starting PHP-FPM..."
/usr/local/sbin/php-fpm --fpm-config /home/container/php-fpm/php-fpm.conf
if [ $? -ne 0 ]; then
    echo "Ошибка при запуске php-fpm"
    exit 0
fi

echo "⟳ Starting Nginx..."
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -e stderr -p /home/container/
if [ $? -ne 0 ]; then
    echo "Ошибка при запуске Nginx"
    exit 0
fi

printf "\033c"

echo -e "${GREEN}╭────────────────────────────────────────────────────────────────────────────────╮${NC}"
echo -e "${GREEN}│   ${BOLD}⚡  WEB | Игровой Хостинг${NC}${GREEN}                                                     │${NC}"
echo -e "${GREEN}│                                                                                │${NC}"
echo -e "${GREEN}│   ✅  ${YELLOW}${BOLD}Веб-сервер(Nginx) успешно запущен${GREEN}                                         │${NC}"
echo -e "${GREEN}│   ✅  ${YELLOW}${BOLD}php-fpm успещно запущен${GREEN}                                                   │${NC}"
echo -e "${GREEN}│   🌍  ${YELLOW}${BOLD}http://${SERVER_IP}:${SERVER_PORT}${GREEN}                                                    │${NC}"
echo -e "${GREEN}│                                                                                │${NC}"
echo -e "${GREEN}│   ${RED}${BOLD}❤️  Qwer-Host |${PURPLE}${BOLD} 2022-2024${NC}${GREEN}                                                     │${NC}"
echo -e "${GREEN}╰────────────────────────────────────────────────────────────────────────────────╯${NC}" 

while true; do
  read -r line
  if [ "${line}" = "stop" ]; then
    /usr/sbin/nginx -s stop -c /home/container/nginx/nginx.conf -e stderr -p /home/container/
    pkill php-fpm
    rm -rf /tmp/*
    exit 0
  fi
done

