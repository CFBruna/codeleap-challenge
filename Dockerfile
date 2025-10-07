FROM python:3.12-slim

RUN addgroup --system app && \
    adduser --system --ingroup app --shell /bin/bash --home /home/app app

ENV PATH="/home/app/.local/bin:${PATH}" \
    PYTHONPATH=/workspace \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    postgresql-client \
    procps \
    git \
    sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "app ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /workspace

COPY --chown=app:app requirements.txt requirements-dev.txt ./

USER app

RUN pip install --user --upgrade pip && \
    pip install --user --no-cache-dir -r requirements-dev.txt

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "src.project.wsgi:application"]
