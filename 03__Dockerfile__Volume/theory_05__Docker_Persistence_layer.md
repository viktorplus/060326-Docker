## Способы сохранения данных контейнера

| Вариант          | Где находятся данные | Кто управляет | Переживают удаление контейнера |
| ---------------- | -------------------- | ------------- | ------------------------------ |
| Named volume     | Docker storage       | Docker        | Да                             |
| Bind mount       | любой каталог хоста  | Вы            | Да                             |
| Anonymous volume | Docker storage       | Docker        | Да, пока volume не удалён      |
| `tmpfs`          | RAM хоста            | Docker/ОС     | Нет                            |

Главное различие:

```text
Named volume
    container -> Docker -> volume
    (управляет Docker)

Bind mount
    container -> конкретный каталог HOST
    (управляет программист)

tmpfs
    container -> RAM
    (управляет Docker)

```

---

### 1. Named volume

Это основной Docker-механизм для persistent data.

Docker сам определяет физическое расположение данных.

Создать:

```bash
docker volume create app_data
```

Посмотреть:

```bash
docker volume ls
```

Использовать:

```bash
docker run \
    --mount source=app_data,target=/app/data \
    myimage
```

или:

```bash
docker run \
    -v app_data:/app/data \
    myimage
```


Посмотреть:

```bash
docker volume inspect app_data
```

Удалить:

```bash
docker volume rm app_data
```

---

### 2. Bind mount

Здесь уже не Docker создаёт отдельное хранилище, 
а сам программист явно указывает, конкретный каталог или файл в файловой системе хоста,  
который будет смонтирован с каталогом / файлом контейнера.

Запуск:

```bash
docker run \
    --mount type=bind,source=/home/user/project/data,target=/app/data \
    myimage
```

или:

```bash
docker run \
    -v /home/user/project/data:/app/data \
    myimage
```

---

### 3. Anonymous volume

Можно объявить:

```dockerfile
VOLUME /app/data
```

```bash
docker run myimage
```

Docker сам создаст volume для:

```text
/app/data
```

Проверить:

```bash
docker volume ls
```

Если в Dockerfile указан VOLUME и при запуске контейнера он не смонтирован явно,  
то Docker даст ему сгенерированное имя.

```text
DRIVER    VOLUME NAME
local     8f4a7c9e...
```

- Это не совсем удобно для работы.
- легко потерять при очистке неиспользуемых volumes или при удалении контейнера с `-v`.

---

### 4. `tmpfs`

Данные находятся в оперативной памяти хоста.

После удаления/остановки контейнера они исчезают.

```bash
docker run \
    --mount type=tmpfs,target=/app/tmp \
    myimage
```

`tmpfs` используют, когда данные нельзя или не нужно писать на диск.

---

### 5. Команды работы с Docker volumes

| Задача                                 | Команда                                                 | Что делает                                       |
| -------------------------------------- | ------------------------------------------------------- | ------------------------------------------------ |
| Посмотреть все тома                    | `docker volume ls`                                      | Показывает список Docker volumes                 |
| Создать том                            | `docker volume create myvolume`                         | Создаёт именованный том                          |
| Посмотреть информацию о томе           | `docker volume inspect myvolume`                        | Показывает параметры и место хранения            |
| Удалить том                            | `docker volume rm myvolume`                             | Удаляет том                                      |
| Удалить все неиспользуемые тома        | `docker volume prune`                                   | Удаляет volumes, не используемые контейнерами    |
| Посмотреть тома конкретного контейнера | `docker inspect container_name`                         | В секции `Mounts` показывает подключённые тома   |
| Подключить volume при запуске          | `docker run -v myvolume:/data image`                    | Монтирует `myvolume` в `/data`                   |
| То же через `--mount`                  | `docker run --mount source=myvolume,target=/data image` | Более явный синтаксис монтирования               |
| Подключить bind mount                  | `docker run -v /home/user/data:/data image`             | Монтирует каталог хоста                          |
| Создать временный `tmpfs`              | `docker run --tmpfs /tmp image`                         | Создаёт `tmpfs` внутри контейнера                |
| Посмотреть контейнеры и их mounts      | `docker ps` + `docker inspect`                          | Позволяет определить, какие volumes используются |
