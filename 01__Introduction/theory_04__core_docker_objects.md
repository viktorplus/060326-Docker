 ### Основные Docker объекты
 
#### Image (образ)

* Шаблон для создания контейнеров.  
* Неизменяемый (`read-only`).  
* Состоит из слоёв.  
* Обычно хранится в реестре (`Docker Hub`, etc).

```
┌──────────────┐      docker build       ┌──────────────┐      docker run      ┌──────────────┐
│  Dockerfile  │ ──────────────────────► │ Docker Image │ ───────────────────► │  Container   │
│ «инструкция» │                         │   «образ»    │                      │ «экземпляр»  │
└──────────────┘                         └──────────────┘                      └──────────────┘
```

##### Пример Python-проекта для иллюстрации

`Dockerfile`:

```dockerfile
# Layer 1 — Base Image
FROM python:3.12-slim

# Layer 2 — Packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# Layer 3 — Dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Layer 4 — Application
COPY app.py .

CMD ["python", "app.py"]
```

`requirements.txt`:

```text
requests
```

`app.py`:

```python
import requests

print("Hello from Docker!")
```

```text
                    Dockerfile
                        │
              команда docker build 
      (создаёт образ по инструкции докер-файла)
                        ▼
              ┌───────────────────┐
              │ Application       │
              ├───────────────────┤
              │ Dependencies      │
              ├───────────────────┤
              │ Packages          │
              ├───────────────────┤
              │ Base Image        │
              └───────────────────┘
                   Docker Image
                        │
                команда docker run 
      (создаёт и запускает контейнер из образа)
                        ▼
              ┌───────────────────┐
              │                   │ 
              │                   │
              └───────────────────┘
                    Container
```

---


#### Container (контейнер) 

* Экземпляр образа.  
* Может иметь несколько состояний (running, stopped, paused, etc). 
* Изолирован, имеет собственную 
  * файловую систему, 
  * процессы, 
  * сетевое пространство(IP-адрес, интерфейсы, маршруты и порты).
* Удаление контейнера —> удаление всех данных внутри него.

---


#### Volume (том)

* Постоянное хранилище данных, управляемое Docker.  
* Существует независимо от контейнера.  
* Несколько контейнеров могут использовать один том.  
* Данные сохраняются при удалении контейнера.


---

#### Network (сеть)  

* Соединяет контейнеры между собой и с хостом. 
* Типы: 
  * bridge (по умолчанию), 
  * host, 
  * overlay (для Swarm), 
  * none.
* Позволяет контейнерам обнаруживать друг друга по имени.


