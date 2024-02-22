FROM python:3.9-slim AS build
RUN mkdir /app
COPY . /app
RUN pip install -r requirements.txt


FROM python:3.11-alpine
COPY --from=build /app  /app
WORKDIR /app
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]