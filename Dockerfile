FROM python:3.9-slim AS build

# Create the application directory and copy code
RUN mkdir /app
COPY . /app

# Set working directory and install requirements
WORKDIR /app
RUN pip install -r requirements.txt

# Use a multi-stage build for smaller image size
FROM python:3.9-slim AS final

# Copy application code from build stage
COPY --from=build /app /app

# Set working directory and expose port
WORKDIR /app
EXPOSE 8000

# Use CMD for default startup behavior
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
