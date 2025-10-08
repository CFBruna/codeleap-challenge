FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system app && \
    adduser --system --ingroup app --shell /bin/bash --home /home/app app

ENV PATH="/home/app/.local/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONTWRITEBYTECODE=1

WORKDIR /workspace

COPY --chown=app:app requirements.txt requirements-dev.txt ./

USER app
RUN pip install --user --upgrade pip && \
    pip install --user --no-cache-dir -r requirements-dev.txt

USER root
COPY --chown=app:app . .

RUN chown -R app:app /workspace
USER app

RUN SECRET_KEY='django-insecure-dummy-key-for-build' DEBUG=False python manage.py collectstatic --noinput

CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn --bind 0.0.0.0:${PORT:-8000} --workers 2 src.project.wsgi:application"]
