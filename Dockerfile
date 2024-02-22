FROM python:3.9-slim as build
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

FROM python:3.9-slim
WORKDIR /app
COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]