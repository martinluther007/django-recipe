FROM python:3.9-alpine3.13
LABEL maintainer='martinlutherakuhwa@gmail.com'

ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /tmp/requirements.txt

COPY ./requirements.dev.txt /tmp/requirements.dev.txt

COPY ./app /app
WORKDIR /app

EXPOSE 9000

ARG DEV=false
RUN python -m venv / py && \
pip install --upgrade pip && \
pip install -r /tmp/requirements.txt && \
if [ $DEV = "true" ]; \
    then pip install -r /tmp/requirements.dev.txt;\
fi && \
rm -rf /tmp && \
adduser \
--disabled-password \
--no-create-home \
django-user

ENV path="/py/bin:$PATH"

USER django-user