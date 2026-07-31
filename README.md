# Jaffle Semantic Layer Testing

This repo is a small dbt project for exercising Semantic Layer patterns on top of the Jaffle Shop dataset.

Today the checked-in project is configured for **DuckDB** for local development:

- `dbt_project.yml` uses the `duckdb` profile
- `profiles.yml` points at a local `jaffle_shop.duckdb` file
- seeds live under `jaffle-data/`

The project includes:

- staging models in `models/staging`
- marts in `models/marts`
- saved queries in `models/saved_queries`
- semantic layer configuration alongside marts YAML
- CI that installs dependencies and runs `dbt build` on pull requests

## Repo layout

```text
models/
  staging/
  marts/
  saved_queries/
macros/
jaffle-data/
tests/
analyses/
```

## Development

This repo is set up to work well in a devcontainer. If you want to run it outside the container, local setup is straightforward.

### Local setup

1. Create and activate a virtual environment.
2. Install Python dependencies.
3. Install dbt packages.
4. Run the project.

```console
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
dbt deps
dbt build
```

If you prefer using the checked-in task runner, the repo includes a `deps` task that installs Python requirements and dbt packages:

```console
task deps
```

## Profiles and targets

For local development, the checked-in profile is:

```yaml
duckdb:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: "jaffle_shop.duckdb"
```

That means `dbt build` will run against a local DuckDB database unless you intentionally swap to a different profile.

## What gets built

At a high level:

- `models/staging` standardizes the seeded Jaffle Shop inputs
- `models/marts` builds business-facing marts like `orders`, `order_items`, and `customers`
- semantic model and metric definitions are declared in YAML next to the marts
- `models/saved_queries/saved_queries.yml` defines exported saved queries such as `high_value_customers` and `new_customers`

## CI

GitHub Actions runs on pull requests and does the following:

```console
pip install -r requirements.txt
pipx install meltano && meltano install
dbt deps
dbt build
```

If you want a quick pre-PR check locally, run:

```console
dbt build
```

## Notes

A couple of files in the repo still reflect older dbt syntax and conventions, especially in YAML. The README here documents the repo as it exists today rather than implying everything is already on the latest spec.
