# Django API Template Profissional

[![CI/CD Pipeline](https://github.com/CFBruna/django-api-template/actions/workflows/ci.yml/badge.svg)](https://github.com/CFBruna/django-api-template/actions/workflows/ci.yml)

Um template de projeto robusto e "opinionated" para iniciar APIs com Django, Docker e VS Code Devcontainers. Construído com foco em boas práticas de desenvolvimento, segurança e performance desde o primeiro `git init`.

## ✨ Por que usar este template?

-   **Ambiente em Segundos:** Inicie um ambiente de desenvolvimento completo e padronizado com um único clique usando VS Code Devcontainers.
-   **Qualidade de Código Garantida:** Ferramentas de linting, formatação e testes são executadas automaticamente antes de cada `commit` e `push`.
-   **Baseado em Padrões Enterprise:** Configurações de Docker, usuário não-root, healthchecks e redes customizadas que seguem as melhores práticas de produção.

## 🚀 Recursos Inclusos

-   **📦 Containerização Completa:** Ambiente de desenvolvimento com Docker e Docker Compose, otimizado para performance (`--mount=type=cache`).
-   **👨‍💻 Experiência de Desenvolvimento (DX) com VS Code:** Totalmente configurado para desenvolvimento remoto dentro de contêineres (`.devcontainer`).
-   **✅ Qualidade de Código Automatizada:**
    -   `Ruff` para linting e formatação de código.
    -   `Mypy` para checagem estática de tipos.
    -   `pre-commit` e `pre-push` hooks para garantir a qualidade antes de versionar o código.
-   **🧪 Testes Automatizados:** Estrutura pronta para `Pytest`, `pytest-django` e `pytest-cov`.
-   **🔄 CI/CD com GitHub Actions:** Pipeline que roda linting, testes e checagens de segurança a cada push.
-   **🔑 Autenticação Segura:** `djangorestframework-simplejwt` pré-configurado.
-   **📚 Documentação de API:** `drf-spectacular` para geração automática de schemas OpenAPI (Swagger UI/ReDoc).
-   **⚙️ Configuração Robusta:**
    -   `python-decouple` para gerenciar variáveis de ambiente via `.env`.
    -   Usuário não-root (`app`) para maior segurança dentro do contêiner.
    -   `healthcheck` no `docker-compose.yml` para garantir que o banco de dados esteja pronto antes da aplicação iniciar.

---

## ⚡ Guia de Início Rápido (Ambiente de Desenvolvimento)

Existem duas maneiras de rodar este projeto. O método com VS Code Devcontainer é **altamente recomendado**.

### Método 1: VS Code Devcontainer (Recomendado)

Este método configura o ambiente completo, incluindo as extensões do VS Code e o terminal, com um único comando.

**Pré-requisitos:**
-   [Git](https://git-scm.com/)
-   [Docker Desktop](https://www.docker.com/products/docker-desktop/)
-   [VS Code](https://code.visualstudio.com/) com a extensão [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) instalada.

**Passos:**

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/CFBruna/django-api-template.git](https://github.com/CFBruna/django-api-template.git) nome-do-projeto
    cd nome-do-projeto
    ```
2.  **Crie seu arquivo de ambiente:**
    ```bash
    cp .env.example .env
    ```
    > **Importante:** Abra o `.env` e gere uma nova `SECRET_KEY`.

3.  **Abra no VS Code:**
    -   Abra a pasta `nome-do-projeto` no VS Code.
    -   Uma notificação aparecerá no canto inferior direito. Clique em **"Reopen in Container"**.
    -   O VS Code irá construir a imagem Docker e iniciar o ambiente. Este processo pode demorar alguns minutos na primeira vez.

Pronto! Seu ambiente está no ar. O terminal do VS Code já estará **dentro** do contêiner, pronto para receber comandos.

### Método 2: Docker Compose (Manual)

Use este método se você não utiliza o VS Code ou prefere gerenciar os contêineres manualmente.

1.  **Clone e configure o ambiente** (siga os passos 1 e 2 do método anterior).
2.  **Construa e suba os contêineres:**
    ```bash
    docker-compose up --build -d
    ```
Para executar comandos, você usará `docker-compose exec web <comando>`.

---

## 🛠️ Primeiros Passos na Aplicação

Após iniciar o ambiente por qualquer um dos métodos, você precisa preparar o banco de dados e o Django.

Execute os seguintes comandos no terminal apropriado (o terminal integrado do VS Code Devcontainer ou via `docker-compose exec web ...`):

1.  **Aplicar as migrações do banco de dados:**
    ```bash
    python manage.py migrate
    ```
2.  **Criar um superusuário (para o Admin):**
    ```bash
    python manage.py createsuperuser
    ```

---

## ⚙️ Comandos Úteis

Execute de dentro do terminal do Devcontainer ou via `docker-compose exec web ...`.

-   **Iniciar o servidor de desenvolvimento:**
    ```bash
    python manage.py runserver 0.0.0.0:8000
    ```
    -   **Admin:** `http://127.0.0.1:8000/admin/`
    -   **Swagger UI:** `http://127.0.0.1:8000/api/v1/schema/swagger-ui/`
    -   **Health Check:** `http://127.0.0.1:8000/api/v1/status/`

-   **Rodar a suíte de testes:**
    ```bash
    pytest
    ```

-   **Rodar checagens de qualidade manualmente:**
    ```bash
    pre-commit run --all-files
    ```

-   **Gerenciar dependências Python:**
    *Após adicionar uma nova dependência ao `requirements.in` ou `requirements-dev.in`.*
    ```bash
    pip-compile requirements.in
    pip-compile requirements-dev.in
    pip-sync
    ```
