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