### Docker Engine

В официальной документации`Docker Engine` описывается как [клиент-серверная технология](https://docs.docker.com/reference/glossary/):


***Docker Engine is the client-server technology that creates and runs Docker containers.***   
***It includes the Docker daemon (dockerd), REST API, and the Docker CLI client.***

```text
                    DOCKER ENGINE
┌─────────────────────────────────────────────┐
│                                             │
│   Docker CLI             Docker daemon      │
│     (client)                (server)        │
│        │                       │            │
│        └────── REST API ───────┘            │
│                                │            │
│                                ▼            │
│                      containers, images,    │
│                      networks, volumes      │
│                                             │
└─────────────────────────────────────────────┘
```

> Docker Engine — это клиент-серверная технология, которая создаёт и запускает Docker-контейнеры.    
> Она включает Docker daemon (`dockerd`), REST API и клиент Docker CLI.


### Важное замечание
⚠️ **Engine** — не то же самое, что **Host**!

* **Docker Engine** — это "про технологию":
  * **Докер движок** — клиент-серверная технология (daemon + API + CLI). 

* **Docker Host** — это "про архитектуру": 
  * **Докер хост** — физическая машина/виртуальная машина/окружение, где работает `dockerd`. 