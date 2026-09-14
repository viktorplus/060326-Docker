## Оптимизация размера образа

Оптимизированный вариант предыдущего Dockerfile:

```Dockerfile
FROM debian:bookworm-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY file1.txt file2.txt .

EXPOSE 8000

ENV APP_NAME="Docker Demo"

LABEL description="Docker layers demonstration"

RUN echo "Hello Docker" > file3.txt

ENTRYPOINT ["cat"]
CMD ["file3.txt"]
```

### Основные способы оптимизации размера образа

1. Использовать меньший базовый образ:

   ```dockerfile
   FROM debian:bookworm-slim
   ```

>   Можно выбрать ещё меньший образ alpine, но тогда придётся менять RUN:
>   ```dockerfile
>    FROM alpine:3.22
>    WORKDIR /app
>    RUN apk add --no-cache curl
>    ```
 
2. Объединять связанные команды `RUN` в один слой:

   ```dockerfile
   RUN apt update && \
       apt install -y --no-install-recommends curl && \
       rm -rf /var/lib/apt/lists/*
   ```

3. Устанавливать только необходимые зависимости:

   ```dockerfile
   apt install -y --no-install-recommends curl
   ```

4. Удалять кэш пакетного менеджера в том же `RUN`, в котором он был создан:

   ```dockerfile
   rm -rf /var/lib/apt/lists/*
   ```

5. Объединять несколько `COPY`, если независимое кэширование файлов не требуется:

   ```dockerfile
   COPY file1.txt file2.txt .
   ```

6. Не добавлять в образ ненужные файлы — использовать `.dockerignore`.

`EXPOSE`, `ENV`, `LABEL`, `ENTRYPOINT` и `CMD` в данном примере практически не влияют на размер образа и сами по себе оптимизации не требуют.

Multi-stage builds — ещё один важный способ уменьшения размера, но его рассмотрим отдельно.


### Сравнение light vs previous

```text
IMAGE                     ID             DISK USAGE   CONTENT SIZE   EXTRA    
theory3-demo:latest       3ca5f2f6ac14        258MB         78.9MB        
theory4-demo:latest       e0363f7056d2        130MB         32.9MB   
```