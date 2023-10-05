# SwissSchema Playbook

This is maintainer-specific documentation on how to run the project.

## Release Checklist

A task list for whenever a new version is being released.

> Note: the following steps use a fictional version `v1.2.3` to illustrate commands, but it should be replaced with the version to be released.

- [ ] **Ensure the code quality looks good**
  - [ ] `mix format --check-formatted`
  - [ ] `mix test`
  - [ ] `mix dialyzer`
- [ ] **Bump version**
  - [ ] Update version in `mix.exs`
  - [ ] Update suggested version in `readme.md`
  - [ ] Update suggested version in `lib/swiss_schema.ex`
  - [ ] Update the Changelog with important changes
  - [ ] `git commit -am 'chore: bump version to v1.2.3'`
- [ ] **Tag the version-bump commit**
  - [ ] Eg.: `git tag -a -s v1.2.3 -m v1.2.3`
- [ ] **Send version tag to GitHub**
  - [ ] `git push origin v1.2.3`
- [ ] [Create a GitHub release](https://github.com/joeljuca/swiss_schema/releases/new) from version tag
- [ ] **Publish to Hex**
  - [ ] `mix hex.publish`
- [ ] **Run announcements (see below)**
  - [ ] Publish on X
  - [ ] Publish on Mastodon

### Announcing on X

[X](https://x.com) limits each post to 280 characters, so announcements needs to be made in threads.

The first post would look like it:

> _🧙🏻‍♂️ I just released SwissSchema v1.2.3._  
> _#myelixirstatus_
>
> [ Here goes a short note about the release. It's important to write a succint and assertive note. ]
>
> _SwissSchema is available on:_
>
> - _Hex: https://hex.pm/packages/swiss_schema_
> - _GitHub: https://github.com/joeljuca/swiss_schema_

If needed, append threaded posts to highlight important information. Eg.:

> _👉 Also, the project now has two important new documents:_
>
> - _./contributing.md_
> - _./changelog.md_
>
> _With these new resources, I expect to improve the transparency of SwissSchema's development and lifecycle._

End the announcement thread with an informative post about the project:

> _💡 SwissSchema is a query toolkit for Ecto schemas._
>
> _It makes it easy to manipulate data using Ecto schemas by implementing relevant Ecto.Repo Query API and Schema API functions, pre-configured to work specifically with the given Ecto schema._
>
> _Read more at https://github.com/joeljuca/swiss_schema#usage_

Examples taken from the [release announcement for v0.4.1](https://twitter.com/holyshtjoe/status/ 1702692792835686415).

### Announcing on Mastodon and the fediverse

The announcement template for X work for Mastodon instances too, but since they often have more generous limits on post lengths, it's better to group multiple threaded posts into a bigger one, so when people reposts it the whole thread is distributed across the fediverse.
