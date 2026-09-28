
### Классификация состояний контейнера

| Состояние          | Что означает                                      |
|--------------------|---------------------------------------------------|
| **Created**        | Контейнер создан, но ещё не запущен               |
| **Running**        | Контейнер запущен, основной процесс выполняется   |
| **Paused**         | Выполнение процессов контейнера приостановлено    |
| **Restarting**     | Docker пытается перезапустить контейнер           |
| **Stopped/Exited** | Основной процесс завершился, контейнер остановлен |
| **Deleted**        | Контейнер удалён из Docker                        |

Посмотреть состояние:

```bash
docker ps
docker ps -a
docker inspect <container>
```

### Переходы между состояниями

```text
                         docker create
                              │
                              ▼
                       ┌─────────────┐
                       │   CREATED   │
                       └──────┬──────┘
                              │ docker start
                              ▼
                    ┌──────────────────┐
                    │     RUNNING      │◄──────────────┐
                    └──┬────────────┬──┘               │
                       │            │                  │
              docker pause    процесс завершился       │
                       │            │                  │
                       ▼            ▼                  │
                 ┌──────────┐  ┌─────────┐             │
                 │  PAUSED  │  │ STOPPED │             │
                 └────┬─────┘  └────┬────┘             │
                      │             │                  │
             docker unpause    docker start            │
                      │             │                  │
                      └──────► RUNNING ◄───────────────┘
                                     
                       при restart policy
                              │
                              ▼
                       ┌─────────────┐
                       │ RESTARTING  │
                       └──────┬──────┘
                              │
                              ▼
                           RUNNING
```

### Основные команды переходов

```bash
# Только создать
docker create --name mycontainer nginx

# Создать и запустить
# (всегда создаёт новый, а не запускает существующий)
docker run --name mycontainer2 nginx

# CREATED -> RUNNING
docker start mycontainer

# RUNNING -> EXITED
docker stop mycontainer

# RUNNING -> PAUSED
docker pause mycontainer

# PAUSED -> RUNNING
docker unpause mycontainer

# STOPPED -> RUNNING
docker start mycontainer

# RUNNING -> STOPPED -> RUNNING
# STOPPED -> RUNNING
docker restart mycontainer

# Удалить остановленный контейнер
docker rm mycontainer

# Удалить работающий контейнер 
# (сначала останавливает, затем удаляет)
docker rm -f mycontainer
```

В этих командах (кроме `create` и `run`) можно указать: 
* либо имя контейнера, 
* либо его ID 