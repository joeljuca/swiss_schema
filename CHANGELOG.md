# Changelog

This document lists important changes between SwissSchema versions, in descending order.

## v0.5.0

### Features and improvements

- feat: accept custom Ecto repos thru a `:repo` opt (`97c19b7`)

### Docs

- docs: add a [PLAYBOOK.md](PLAYBOOK.md) (`2b58a17`)
- docs: add a [FAQ.md](FAQ.md) (`ea03e14`)
- docs: rewrite the [CONTRIBUTING.md](CONTRIBUTING.md) (`8371cec`)

Plus some other minor overall improvements to documentation.

## v0.4.1

### Bug fixes

- fix: warning on missing callback `aggregate/1` (`e7ec963`)

### Docs

- docs: add a contributing.md (`a75fb49`, `6b91439`, `c047b6c`)

## v0.4.0

### Features and improvements

- refactor: turns SwissSchema into a behaviour (`5347496`)
- docs: add setup and usage instructions to SwissSchema's `@moduledoc` (`5a9f6ba`, `9a1dea3`)

Plus some minor contributions do documentation pages.

## v0.3.2

### Bug fixes

- fix: insert_or_update/2 and insert_or_update!/2 now accepts an Ecto changeset (`5eaceb7`)

Plus some minor contributions to tests.

## v0.3.1

### Bug fixes

- fix: Unknown type: Keyword.list/1 (`fed13ed`)

## v0.3.0

### Features and improvements

- feat: add create!/2 (`0223118`)
- feat: add create/2 (`44d9007`)

Plus some contributions to documentation and tests.

## v0.2.0

### Breaking Changes

- chore!: return values in :ok/:error tuples from get_by/2 (`40f0432`)
- chore!: return values in :ok/:error tuples from get/2 (`5448d86`)

### Bug fixes

- fix: use Repo.delete!/2 in delete!/2 (`055a7e7`)

Plus a lot of new test cases and a rewrite of the SQLite test database setup.

## v0.1.1 (retired)

### Bug fixes

- fix: Ecto.Repo Query API functions not being loaded (`a461062`)

Plus some minor contributions to documentation and tests.

## v0.1.0 (retired)

First release.
