### Команды взаимодействия с контейнером


| Команда         | Обязательное                        | Опциональное                     | Краткое описание                                                         |
| --------------- |-------------------------------------|----------------------------------|--------------------------------------------------------------------------|
| `docker attach` | `<CONTAINER>`                       | `[OPTIONS]`                      | Подключает потоки `STDIN`, `STDOUT` и `STDERR `контейнера к терминалу    |
| `docker cp`     | `<CONTAINER:SRC_PATH>` `<SRC_PATH>` | —                                | Копирует файлы или директории из контейнера на хост                      |
| `docker cp`     | `<SRC_PATH>` `<CONTAINER:SRC_PATH>` | —                                | Копирует файлы или директории с хоста в контейнер                        |
| `docker export` | `<CONTAINER>`                       | `[OPTIONS]`                      | Экспортирует файловую систему контейнера в TAR-архив                     |
| `docker exec`   | `<CONTAINER>` `<COMMAND>`           | `[OPTIONS]`                      | Запускает дополнительную команду **в уже работающем контейнере**         |
| `docker wait`   | `<CONTAINER>`                       | —                                | Ожидает остановки контейнера и выводит exit code его основного процесса. |
| `docker commit` | `<CONTAINER>`                       | `[REPOSITORY[:TAG]]` `[OPTIONS]` | Создаёт новый Docker-образ из текущего состояния контейнера              |

---

#### Уточнение по `docker cp`

У `cp` обязательны **два пути**, один из которых ведёт внутрь контейнера:

```bash
# копируем из контейнера на хост:
docker cp <CONTAINER:SRC_PATH> <DEST_PATH>

# или, наоборот, с хоста в контейнер:
docker cp <SRC_PATH> <CONTAINER:DEST_PATH>
```

Например:

```bash
docker cp mycontainer:/app/config.json ./config.json

docker cp ./config.json mycontainer:/app/config.json
```

---

#### `docker export`

Выгрузить архив файлового дерева контейнера в папку Downloads.

```bash
docker export mycontainer > ~/Downloads/mycontainer.tar
```

---

#### `docker attach` vs `docker exec`

1. Подключиться к **уже существующему** основному процессу контейнера:

```bash
docker attach <CONTAINER>
```

2. Запустить **новый дополнительный** процесс внутри контейнера:

```bash
docker exec <CONTAINER> <COMMAND>
```

