FROM python:3.12-slim as builder

RUN addgroup --system app && \
    adduser --system --ingroup app --shell /bin/bash --home /home/app app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    postgresql-client \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/home/app/.local/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /workspace
COPY --chown=app:app requirements.txt .

USER app

RUN pip install --user --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

FROM python:3.12-slim as final

RUN addgroup --system app && \
    adduser --system --ingroup app --shell /bin/bash --home /home/app app

ENV PATH="/home/app/.local/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /workspace

COPY --chown=app:app --from=builder /home/app/.local /home/app/.local
COPY --chown=app:app . .

USER app

RUN SECRET_KEY='django-insecure-dummy-key-for-build' DEBUG=False python manage.py collectstatic --noinput

CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn --bind 0.0.0.0:${PORT:-8000} --workers 2 src.project.wsgi:application"]
