# Скрипт для встановлення Jenkins у Docker

Цей репозиторій містить скрипт для налаштування Jenkins у контейнері Docker з Docker і Docker Compose, встановленими всередині Jenkins. Скрипт також генерує SSH ключі для Jenkins для полегшення підключення до GitHub.

## Передумови

- Встановлений Docker на хост-машині
- Користувач повинен мати права sudo

## Використання

1. Клонуйте репозиторій:
2. 
   git clone https://github.com/Dymplom.git

Запустіть скрипт налаштування:

sh
Копировать код
.jenkins.sh
Під час виконання скрипта вас буде запитано:

Додати користувача до групи Docker (за бажанням)
Введіть ім'я користувача для додавання до групи Docker
Скрипт виконає наступні дії:

Завантажить Docker образ Jenkins
Видалить будь-який існуючий контейнер Jenkins
Запустить новий контейнер Jenkins з необхідними портами і змінними
Відобразить початковий пароль адміністратора Jenkins
Згенерує SSH ключі всередині контейнера Jenkins
Додасть GitHub до відомих хостів для контейнера Jenkins
Встановить Docker і Docker Compose всередині контейнера Jenkins
Доступ до Jenkins:

Відкрийте веб-браузер і перейдіть до http://localhost:8080. Використовуйте початковий пароль адміністратора, який відобразить скрипт, для розблокування Jenkins.

Деталі скрипта
Скрипт виконує наступні дії:

За бажанням додає вказаного користувача до групи Docker і перезапускає службу Docker
Завантажує Docker образ Jenkins
Видаляє існуючий контейнер Jenkins (якщо такий є)
Запускає новий контейнер Jenkins з привілегіями, маппінгом сокета Docker, необхідними портами та змінними
Очікує 30 секунд для ініціалізації Jenkins та відображає початковий пароль адміністратора
Генерує SSH ключі всередині контейнера Jenkins
Додає GitHub до відомих хостів для контейнера Jenkins
Встановлює Docker та Docker Compose всередині контейнера Jenkins
