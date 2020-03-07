FROM python:3.7-alpine as base
RUN mkdir /install
WORKDIR /install
COPY requirements.txt /requirements.txt
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libffi-dev libxml2-dev libxslt-dev
RUN pip install -r /requirements.txt 

COPY thingsboard_gateway /app/thingsboard_gateway
COPY thingsboard_gateway/config /app/config
WORKDIR /app
RUN mkdir -p /app/logs

ENV configs /app/thingsboard_gateway/config
ENV extensions /app/thingsboard_gateway/extensions
ENV logs /app/logs
ENV PYTHONPATH "${PYTHONPATH}:/app"
VOLUME ["${configs}", "${extensions}", "${logs}"]
WORKDIR /app
CMD [ "python", "./thingsboard_gateway/tb_gateway.py" ]