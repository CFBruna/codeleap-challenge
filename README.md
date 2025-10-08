# CodeLeap Backend Challenge

[![Django CI](https://github.com/CFBruna/codeleap-challenge/actions/workflows/ci.yml/badge.svg)](https://github.com/CFBruna/codeleap-challenge/actions/workflows/ci.yml)

Solução para o desafio técnico de Backend Engineer da CodeLeap, construída com Django, DRF e Docker, e deployada na plataforma Render.

## Links da Aplicação (Live Demo)

* **API Base URL:** `https://codeleap-challenge-api-mqvl.onrender.com/`
* **Health Check:** `https://codeleap-challenge-api-mqvl.onrender.com/api/v1/status/`
* **Documentação (Swagger UI):** `https://codeleap-challenge-api-mqvl.onrender.com/api/v1/schema/swagger-ui/`
* **Documentação (ReDoc):** `https://codeleap-challenge-api-mqvl.onrender.com/api/v1/schema/redoc/`

## Tech Stack

* **Backend:** Python, Django, Django REST Framework
* **Banco de Dados:** PostgreSQL
* **DevOps:** Docker, GitHub Actions (CI/CD), Render (PaaS)
* **Qualidade de Código:** Pytest, Ruff, Mypy, Pre-commit
* **API:** OpenAPI (via drf-spectacular)

## Decisões de Arquitetura e Boas Práticas Implementadas

Além dos requisitos básicos do CRUD, o projeto foi desenvolvido seguindo padrões de mercado para garantir qualidade, segurança e manutenibilidade:

* **Containerização Completa:** A aplicação é totalmente containerizada com Docker, garantindo um ambiente consistente do desenvolvimento à produção.
* **Integração Contínua (CI):** Um pipeline no GitHub Actions é executado a cada push, rodando testes automatizados, linting, checagem de tipos e análise de segurança para garantir a integridade do código.
* **Testes Automatizados:** Cobertura de testes para os endpoints da API utilizando `pytest` para assegurar o funcionamento correto das funcionalidades.
* **Documentação Automática da API:** Utilização do `drf-spectacular` para gerar um schema OpenAPI, com interfaces Swagger UI e ReDoc disponíveis para fácil exploração e consumo da API.
* **Segurança:** A imagem Docker utiliza um usuário não-root, seguindo as melhores práticas de segurança para ambientes containerizados.
* **Gerenciamento de Dependências:** Uso de `pip-tools` para um gerenciamento de dependências preciso e reprodutível.

## Como Executar Localmente

O projeto é configurado para rodar facilmente com Docker e VS Code Dev Containers.

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/CFBruna/codeleap-challenge.git](https://github.com/CFBruna/codeleap-challenge.git)
    cd codeleap-challenge
    ```
2.  **Crie o arquivo de ambiente:**
    ```bash
    cp .env.example .env
    ```
    *(É necessário preencher as variáveis no arquivo `.env` para rodar localmente)*

3.  **Suba os containers:**
    ```bash
    docker-compose up --build
    ```
A aplicação estará disponível em `http://127.0.0.1:8000`.
