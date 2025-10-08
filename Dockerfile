# ==============================================================================
# MULTI-STAGE DOCKERFILE FOR PRODUCTION
# ==============================================================================
FROM python:3.12-slim as base

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    postgresql-client \
    procps \
    git \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ==============================================================================
# DEVELOPMENT STAGE
# ==============================================================================
FROM base as development

RUN addgroup --system app && \
    adduser --system --ingroup app --shell /bin/bash --home /home/app app

RUN echo "app ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV PATH="/home/app/.local/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /workspace

COPY --chown=app:app requirements.txt requirements-dev.txt ./

USER app

RUN pip install --user --upgrade pip && \
    pip install --user --no-cache-dir -r requirements-dev.txt

COPY --chown=app:app . .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# ==============================================================================
# PRODUCTION STAGE
# ==============================================================================
FROM base as production

RUN addgroup --system app && \
    adduser --system --ingroup app --no-create-home app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH="/app/.local/bin:${PATH}" \
    DJANGO_SETTINGS_MODULE=src.project.settings

WORKDIR /app

COPY --chown=app:app requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY --chown=app:app . .

USER app

RUN python manage.py collectstatic --noinput --clear


HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:${PORT:-8000}/api/v1/status/ || exit 1

CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:${PORT:-8000} --workers 2 --threads 2 --timeout 120 --access-logfile - --error-logfile - src.project.wsgi:application"]

# ==============================================================================
# DEFAULT STAGE (PRODUCTION)
# ==============================================================================
FROM production
