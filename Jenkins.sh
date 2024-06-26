#!/bin/bash

# Пуллінг останнього образу Jenkins
docker pull jenkins/jenkins

# Створення каталогу для зберігання даних Jenkins
mkdir -p /var/jenkins_home

# Налаштування прав доступу до каталогу
chmod 777 /var/jenkins_home/ -R

# Запуск Jenkins у контейнері Docker
docker run -p 8080:8080 -d -v /var/jenkins_home:/var/jenkins_home/ jenkins/jenkins

# Генерація SSH ключів
echo "y" | ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -C "sashadrozdov@icloud.com" -P ""

# Підготовка каталогу та копіювання SSH ключів для Jenkins
mkdir -p /var/lib/jenkins/.ssh/
cp /root/.ssh/id_ed25519 /var/lib/jenkins/.ssh/
cp /root/.ssh/id_ed25519.pub /var/lib/jenkins/.ssh/
chmod 700 /var/lib/jenkins/.ssh/
chmod 600 /var/lib/jenkins/.ssh/id_ed25519
chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub

# Вивід ключів та паролю для першого входу
echo -e "\n\t КЛЮЧ ВІД JENKINS\n"
cat /var/jenkins_home/secrets/initialAdminPassword
echo -e "\n\t SSH_KEY.pub\n"
cat /root/.ssh/id_ed25519.pub
echo -e "\n\t SSH_KEY.priv\n"
cat /root/.ssh/id_ed25519
echo -e "\n\n"
