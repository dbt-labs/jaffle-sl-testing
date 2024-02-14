# Jaffle Semantic Layer Testing

This is a repo that is used to test the Semantic Layer

## How to use

This project uses devcontainers. Learn how to integrate devcontainers with your IDE [here](https://containers.dev/supporting)

## Local development

This project is optimized for running in a container. If you'd like to use it locally outside of container you'll need to follow the instructions below.

1. Create a python virtual environment and install the dependencies.

```console
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

2. Seed files don't work as expected with Databricks, so there are none on this branch. Instead, ensure that you upload [these](https://github.com/dbt-labs/jaffle-sl-testing/tree/main/jaffle-data) files individually by following [these](https://docs.databricks.com/en/ingestion/add-data/upload-data.html) instructions.

3. Install dbt dependencies and build the dbt project.

```console
dbt deps
dbt build
```


