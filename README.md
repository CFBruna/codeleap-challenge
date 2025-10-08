# CodeLeap Backend Challenge

[![Django CI](https://github.com/CFBruna/codeleap-challenge/actions/workflows/ci.yml/badge.svg)](https://github.com/CFBruna/codeleap-challenge/actions/workflows/ci.yml)

A solution for the CodeLeap Backend Engineer technical challenge, built with Django, DRF, and Docker, and deployed on the Render platform.

## Application Links (Live Demo)

* **API Base URL:** `https://codeleap-challenge-api-mqvl.onrender.com/careers/`
* **Health Check:** `https://codeleap-challenge-api-mqvl.onrender.com/api/v1/status/`
* **Documentation (Swagger UI):** `https://codeleap-challenge-api-mqvl.onrender.com/api/v1/schema/swagger-ui/`
* **Documentation (ReDoc):** `https://codeleap-challenge-api-mqvl.onrender.com/api/v1/schema/redoc/`

*Note: The main API endpoint (`/careers/`) will return an "authentication credentials were not provided" message. This is the expected behavior, as the API is secure by default, configured with `IsAuthenticated` in the Django REST Framework.*

## Tech Stack

* **Backend:** Python, Django, Django REST Framework
* **Database:** PostgreSQL
* **DevOps:** Docker, GitHub Actions (CI/CD), Render (PaaS)
* **Code Quality:** Pytest, Ruff, Mypy, Pre-commit
* **API:** OpenAPI (via drf-spectacular)

## Architectural Decisions and Best Practices

Beyond the basic CRUD requirements, this project was developed using industry-standard patterns to ensure quality, security, and maintainability:

* **Full Containerization:** The application is fully containerized with Docker, ensuring a consistent environment from development to production.
* **Continuous Integration (CI):** A GitHub Actions pipeline runs on every push, executing automated tests, linting, type-checking, and security scans to ensure code integrity.
* **Automated Testing:** API endpoints are covered by a test suite using `pytest` to guarantee correct functionality.
* **Automatic API Documentation:** The project uses `drf-spectacular` to generate an OpenAPI schema, with Swagger UI and ReDoc interfaces available for easy API exploration and consumption.
* **Security:** The Docker image uses a non-root user, following security best practices for containerized environments.
* **Dependency Management:** The project uses `pip-tools` for precise and reproducible dependency management.

## How to Run Locally

This project is configured to run easily with Docker and VS Code Dev Containers.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/CFBruna/codeleap-challenge.git](https://github.com/CFBruna/codeleap-challenge.git)
    cd codeleap-challenge
    ```
2.  **Create the environment file:**
    ```bash
    cp .env.example .env
    ```
    *(You must fill in the variables in the `.env` file to run the project locally)*

3.  **Build and run the containers:**
    ```bash
    docker-compose up --build
    ```
The application will be available at `http://127.0.0.1:8000`.
