#
# Python Flask
#

FROM  python:3.7

COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["main.py"]

# Port 5000 on host and 5000 port in container
EXPOSE 5000:5000
