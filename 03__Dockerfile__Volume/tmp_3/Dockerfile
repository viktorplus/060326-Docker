FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y curl

WORKDIR /app

COPY fetch_data.sh .

ENV URL_ENV="https://httpbin.org/json"

RUN useradd --create-home new_user \
    && chown new_user:new_user /app/fetch_data.sh \
    && chmod +x /app/fetch_data.sh

VOLUME /data

USER new_user

CMD ["./fetch_data.sh"]
