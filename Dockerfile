FROM python:3.11-slim

WORKDIR /app

# Install uv
RUN pip install uv

# Copy pyproject.toml and install dependencies
COPY pyproject.toml ./
RUN uv sync --frozen --no-install-project

# Copy application code
COPY . .

# Create data directory for SQLite
RUN mkdir -p /app/data

# Expose port
EXPOSE 8000

# Environment defaults
ENV APP_HOST=0.0.0.0
ENV APP_PORT=8000
ENV APP_DATABASE_URL=data/database.db

CMD ["uv", "run", "python", "webui.py"]
