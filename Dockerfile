# Stage 1: Build environment
FROM python:3.9-slim AS builder
WORKDIR /app
COPY requirements.txt .

# Install dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime environment
FROM python:3.9-slim AS final
WORKDIR /app

# Copy the installed dependencies from the builder stage
COPY --from=builder /root/.local /root/.local

# Copy application code
COPY . .

# Add the local bin directory to the PATH
ENV PATH=/root/.local/bin:$PATH

# Expose port 8000
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
