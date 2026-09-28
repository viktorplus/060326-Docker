Основная команда сборки Docker-образа:

```bash
docker build -t <имя_образа>:<тег> <путь_к_контексту>
```

Например:

```bash
docker build -t ng-image:new .
```

Здесь:

* `docker build` — собрать образ;
* `-t ng-image:new` — задать имя и тег образа;
* `.` — текущий каталог как build context.

### Основные параметры

```bash
docker build \
    -t myapp:1.0 \
    -f Dockerfile \
    --build-arg PYTHON_VERSION=3.12 \
    .
```

| Параметр       | Назначение                                             |
| -------------- |--------------------------------------------------------|
| `-t`, `--tag`  | имя и тег образа                                       |
| `-f`, `--file` | указать Dockerfile                                     |
| `--build-arg`  | передать переменную `ARG` в Dockerfile                 |
| `--no-cache`   | полностью отключить использование кэша                 |
| `--pull`       | всегда пытаться получить свежую версию базового образа |
| `--platform`   | указать платформу, например `linux/amd64`              |
| `--target`     | собрать конкретный stage из multi-stage Dockerfile     |
| `--progress`   | режим вывода процесса сборки (`auto`, `plain`, `tty`)  |


#### Пример 1: обычная сборка

```bash
docker build -t myapp:latest .
```

#### Пример 2: гарантированно свежая сборка

```bash
docker build --pull --no-cache -t myapp:latest .
```

Если Dockerfile называется не `Dockerfile`, например `Dockerfile.dev`:

```bash
docker build -f Dockerfile.dev -t myapp:dev .
```

---

### Работа с кэшем сборки Docker

Кэширование - это и плюс, и минус одновременно:

* с одной стороны экономит время сборки образа;
* с другой стороны - это весьма ресурсозатратная услуга (занимает память на диске).

| Задача                                   | Команда                                | Что делает                                              |
| ---------------------------------------- | -------------------------------------- | ------------------------------------------------------- |
| Посмотреть build cache                   | `docker builder du`                    | Показывает размер и состояние build cache               |
| Подробно посмотреть build cache          | `docker builder du -v`                 | Показывает подробную информацию о cache                 |
| Очистить build cache                     | `docker builder prune`                 | Удаляет неиспользуемый build cache                      |
| Очистить весь неиспользуемый build cache | `docker builder prune -a`              | Удаляет весь неиспользуемый cache                       |
| Очистить cache без подтверждения         | `docker builder prune -af`             | То же самое, но без запроса                             |
| Посмотреть images                        | `docker images`                        | Показывает Docker images                                |
| Удалить image                            | `docker rmi <IMAGE>`                   | Удаляет указанный image                                 |
| Удалить неиспользуемые images            | `docker image prune -a`                | Удаляет images, не используемые контейнерами            |
| Удалить всё неиспользуемое               | `docker system prune`                  | Удаляет неиспользуемые контейнеры, сети, images и cache |
| Расширенная очистка                      | `docker system prune -a`               | То же, плюс неиспользуемые images                       |
| Собрать без cache                        | `docker build --no-cache -t <IMAGE> .` | Игнорирует cache при сборке                             |

