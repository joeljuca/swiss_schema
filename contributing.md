# Contribution Guide

This document gathers information about how to maintain and contribute to SwissSchema.

## Commits How-To

- Commit messages must follow [Conventional Commits](https://www.conventionalcommits.org)
- Updates to deps list must be isolated
- Every commit must pass all build steps (style, analysis, test, etc.)

## Release How-To

To release a new version, follow the steps below.

- Ensure code style, tests, and dialyzer are looking good
  - `mix format --check-formatted`
  - `mix test`
  - `mix dialyzer`
- Update the Changelog with important changes
- Bump version
  - Update version in `mix.exs`
  - Update suggested version in `readme.md`
  - Update suggested version in `lib/swiss_schema.ex`
  - `git commit -m 'chore: bump version to v1.2.3'`
- Tag the version commit
  - Eg.: `git tag -a -s v1.2.3 -m v1.2.3`
- Send version tag to GitHub
  - `git push origin v1.2.3`
- Create a GitHub release from version tag
- Publish to Hex
  - `mix hex.publish`

> Note: the following steps use a fictional version `v1.2.3` to illustrate commands, but it should be replaced with the version to be released.
