# Jaffle Semantic Layer Testing

This is a repo that is used to test the Semantic Layer

## How to use

This project uses devcontainers. Learn how to integrate devcontainers with your IDE [here](https://containers.dev/supporting)

## Local development

This project is optimized for running in a container. If you'd like to use it locally outside of container you'll need to follow the instructions below.

1. Install [Poetry](https://python-poetry.org/)

2. Install project's dependencies by running:
```console
python3 -m poetry install --with=dev
poetry run dbt deps
poetry run pre-commit install
```

3. Build the dbt project by running:
```console
poetry run dbt build
```
