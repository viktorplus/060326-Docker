
### Dockerfile

```dockerfile
FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl

WORKDIR /app

COPY file1.txt .
ADD file2.txt .

EXPOSE 8000

ENV APP_NAME="Docker Demo"

LABEL description="Docker layers demonstration"

RUN echo "Hello Docker" > file3.txt

ENTRYPOINT ["cat"]
CMD ["file3.txt"]
```


### Посмотреть слои

Команда:

```bash
docker history theory3-demo
```

должна дать примерно такой результат:

```text
docker history theory3-demo
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
3ca5f2f6ac14   10 seconds ago   CMD ["file3.txt"]                               0B        buildkit.dockerfile.v0
<missing>      10 seconds ago   ENTRYPOINT ["cat"]                              0B        buildkit.dockerfile.v0
<missing>      10 seconds ago   RUN /bin/sh -c echo "Hello Docker" > file3.t…   12.3kB    buildkit.dockerfile.v0
<missing>      10 seconds ago   LABEL description=Docker layers demonstration   0B        buildkit.dockerfile.v0
<missing>      10 seconds ago   ENV APP_NAME=Docker Demo                        0B        buildkit.dockerfile.v0
<missing>      10 seconds ago   EXPOSE [8000/tcp]                               0B        buildkit.dockerfile.v0
<missing>      10 seconds ago   ADD file2.txt /app/ # buildkit                  8.19kB    buildkit.dockerfile.v0
<missing>      10 seconds ago   COPY file1.txt /app/ # buildkit                 8.19kB    buildkit.dockerfile.v0
<missing>      10 seconds ago   WORKDIR /app                                    8.19kB    buildkit.dockerfile.v0
<missing>      10 seconds ago   RUN /bin/sh -c apt install -y curl # buildkit   21.8MB    buildkit.dockerfile.v0
<missing>      23 seconds ago   RUN /bin/sh -c apt update # buildkit            42.4MB    buildkit.dockerfile.v0
<missing>      3 weeks ago      umoci raw add-layer --image /home/buildd/roc…   12.3kB    Add rock control metadata
```

Здесь хорошо видно важное правило:

### Какие инструкции создают слои

| Инструкция   |                             Создаёт слой? |
| ------------ |------------------------------------------:|
| `FROM`       |          Да, берётся слой базового образа |
| `RUN`        |                                        Да |
| `COPY`       |                                        Да |
| `ADD`        |                                        Да |
| `WORKDIR`    |    Может создавать изменения в filesystem |
| `CMD`        |                                       Нет |
| `ENTRYPOINT` |                                       Нет |
| `ENV`        |                                       Нет |
| `EXPOSE`     |                                       Нет |


