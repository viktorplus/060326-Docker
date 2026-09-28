
### Команды работы с Docker-образами

| Команда          | Обязательное                      | Опциональное                     | Краткое описание                                                                |
| ---------------- | --------------------------------- | -------------------------------- | ------------------------------------------------------------------------------- |
| `docker images`  | —                                 | `[OPTIONS]` `[REPOSITORY[:TAG]]` | Показывает список Docker-образов, доступных локально                            |
| `docker history` | `<IMAGE>`                         | `[OPTIONS]`                      | Показывает историю слоёв и команд, из которых был создан образ                  |
| `docker inspect` | `<NAME\|ID>`                      | `[OPTIONS]`                      | Выводит подробную информацию об образе или другом Docker-объекте в формате JSON |
| `docker tag`     | `<SOURCE_IMAGE>` `<TARGET_IMAGE>` | —                                | Создаёт дополнительный тег (имя и/или версию) для существующего образа          |
| `docker commit`  | `<CONTAINER>`                     | `[REPOSITORY[:TAG]]` `[OPTIONS]` | Создаёт новый Docker-образ из текущего состояния контейнера                     |
| `docker import`  | `<file\|URL\|->`                  | `[REPOSITORY[:TAG]]` `[OPTIONS]` | Создаёт Docker-образ из файловой системы TAR-архива                             |
| `docker rmi`     | `<IMAGE>`                         | `[IMAGE...]` `[OPTIONS]`         | Удаляет один или несколько Docker-образов из локального хранилища               |

---

#### `docker commit` vs `docker import`

У `docker commit` и `docker import` похожий результат — **создание образа**, но источник разный:

```bash
# из существующего контейнера:
docker commit <CONTAINER> <REPOSITORY>:<TAG>

# из TAR-архива файловой системы:
docker import <file.tar> <REPOSITORY>:<TAG>
```


#### Удаление нескольких образов

```bash
docker rmi image1 image2 image3
```

---

#### Удаление всех образов

```bash
docker rmi $(docker images -q)
```

Если образы используются существующими контейнерами, Docker может не позволить их удалить.  

Для принудительного удаления всех:

```bash
docker rmi -f $(docker images -q)
```

---

#### Удаление неиспользуемых образов

```bash
docker rmi $(docker images -q)

# либо 
docker image prune -a
```



