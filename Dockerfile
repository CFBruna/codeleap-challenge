FROM python:3.12-slim

RUN addgroup --system app && \
    adduser --system --ingroup app --shell /bin/bash --home /home/app app

ENV PATH="/home/app/.local/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    postgresql-client \
    procps \
    git \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY --chown=app:app requirements.txt ./

USER app

RUN pip install --user --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

COPY --chown=app:app . .

CMD ["sh", "-c", "python manage.py collectstatic --noinput && python manage.py migrate --noinput && gunicorn --bind 0.0.0.0:${PORT:-8000} --workers 2 --threads 4 --timeout 120 --access-logfile - --error-logfile - src.project.wsgi:application"]
