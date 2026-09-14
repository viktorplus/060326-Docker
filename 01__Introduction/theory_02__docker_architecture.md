## Docker Architecture

![https://docs.docker.com/get-started/images/docker-architecture.webp](images/docker-architecture.webp)

---

### 1. Docker Client 

Это интерфейс, с помощью которого пользователь (или другая программа) взаимодействует с `Docker daemon`.


Структурно это можно изобразить примерно так:

```
Docker CLI ──┐
             ├──→ Docker API ──→ Docker daemon
Docker SDK ──┘
```

Где:
* `Docker API` — интерфейс взаимодействия с `Docker daemon` (чаще через HTTP)
* `Docker CLI` — консольный клиент для взаимодействия с `Docker daemon` через API
* `Docker SDK` — набор библиотек, позволяющий программам удобно работать с `Docker API`

---

### 2. Docker Host 

Машина/окружение, на котором работает `Docker daemon`.

#### Docker daemon (dockerd) 

Постоянно работающий серверный процесс, который 
* принимает Docker API-запросы 
* и управляет жизненным циклом Docker-объектов.


> Древнегреческое δαίμων (daímōn) — это не совсем «демон» в современном христианском смысле.  
> Это скорее дух, сверхъестественное существо или посредник между богами и людьми.  
> Так что в метафорическом смысле:  
> daemon — это невидимый дух, который самостоятельно выполняет работу, пока человек занимается своими делами.


#### Docker objects 

`Docker objects` — сущности, которыми управляет Docker daemon.  

К основным объектам относятся:
  * `Containers` (контейнеры)
  * `Images` (образы)
  * `Networks` (сети)
  * `Volumes`  (тома)


---

### 3. Docker Registry

Docker Registry — это хранилище Docker-образов.

Самый известный пример **Docker Hub**.

Публичные образы здесь могут храниться бесплатно.  

Для хранения приватных образов есть множество других частных Docker Registry:
* **Amazon Elastic Container Registry (ECR)** — registry от AWS.
* **Google Artifact Registry** — registry от Google Cloud.
* **GitHub Container Registry (GHCR)** — registry, интегрированный с GitHub.
* **GitLab Container Registry** — registry, встроенный в GitLab.

Условия хранения приватных образов зависят от конкретного сервиса и тарифного плана.


