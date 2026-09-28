#!/bin/bash

curl "$URL_ENV" -o /data/info.json

echo "The data was loaded from: $URL_ENV"