FROM python:3.6.0-alpine

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
WORKDIR /app
COPY . /app
RUN apk --no-cache --update add build-base && \
    pip install -r /app/requirements.txt && \
    apk del build-base
RUN pip --no-cache-dir install "markupsafe==1.1.1"
ENTRYPOINT ["python3", "post_app.py"]