# Project Rules

## Layout and naming
- Keep staging models in `models/staging`; configure them as views.
- Start every staging model SQL and YAML filename with `stg_`; CI checks this in `.github/workflows/file-naming-conventions-check.yml`.
- Keep staging models one-to-one with a raw table; do not join or aggregate there.
- Have staging models `ref()` the raw seeds directly; do not replace those references with `source()`.
- Keep marts in `models/marts`; configure them as tables and use plain-English entity names without a prefix.
- Keep exactly one YAML file per model, beside its SQL file and with the same basename (for example, `orders.sql` and `orders.yml`).
- Put sources only in `models/staging/__sources.yml`; never create `schema.yml` or `_models.yml`.

## Tests and documentation
- Give every model a primary key and test it with `unique` and `not_null` under `data_tests:`; never use `tests:`.
- Put generic test arguments under `arguments:`; `dbt_project.yml` enables `require_generic_test_arguments_property`.
- Add a `relationships` test for every foreign key in a mart.
- Whenever you add a test to a column, describe that column in the house style, such as `The unique key of the orders mart.` Some existing tested columns lack descriptions; bring them into compliance when you edit their YAML.
- Derive the primary key from the model description's “one row per X” grain. If the description and SQL disagree, stop and ask; never invent a composite key.
- For work limited to tests or documentation, edit YAML only; do not edit SQL.

## Protected files and paths
- Do not edit `seeds/jaffle-data/*.csv`, `macros/generate_schema_name.sql`, or `.github/workflows/` unless asked.
- Do not edit generated paths or artifacts: `target/`, `dbt_packages/`, `dbt_internal_packages/`, `logs/`, and `workshop.duckdb`.
- Leave `models/marts/supplies.sql`'s intentional SQLFluff violation in place for the workshop demo.

## Running locally
- Target dbt-core 1.10 compatibility: CI runs dbt-core 1.10.10 with dbt-duckdb, even though local dbt is 2.0.x.
- Build a selected model with `dbt build --profiles-dir . --select <model>`.
- Expect dbt and `dbt deps` to need network access to fetch dependencies, including the DuckDB driver. If network is unavailable, say dbt could not run; never claim the change was verified.
- If dbt 2.0 parsing rewrites `.gitignore` or `package-lock.yml`, restore those generated changes before finishing with `git checkout -- .gitignore package-lock.yml`.

## Finishing
- End each task report with the files changed, the exact dbt command run, and whether verification passed, failed, or could not run and why.
