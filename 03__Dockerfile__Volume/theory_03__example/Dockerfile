FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl

WORKDIR /app

COPY file1.txt /app/
ADD file2.txt /app/

EXPOSE 8000

ENV APP_NAME="Docker Demo"

LABEL description="Docker layers demonstration"

RUN echo "Hello Docker" > file3.txt

ENTRYPOINT ["cat"]
CMD ["file3.txt"]