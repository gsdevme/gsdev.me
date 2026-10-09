# gsdev.me

Personal blog for [gsdev.me](https://www.gsdev.me), built with [Jekyll](https://jekyllrb.com/) and the
[Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme. The theme is pulled in as a gem, so
layouts, includes and styles live in the gem rather than this repository. See the
[Chirpy docs](https://chirpy.cotes.page/) for theme configuration.

## Local development

Everything runs inside a `ruby:3.4` container via rootless Podman's `docker compose` shim, so no local
Ruby is needed. The compose file sets `userns_mode: keep-id`, which plain Docker rejects; remove that
line from `infrastructure/docker-compose.yaml` to use Docker instead.

```bash
make          # serve on http://localhost:4000 with live reload
make test     # production build plus html-proofer (the same check CI runs)
make shell    # open a shell in the container
make clean    # stop containers and remove build and bundle caches
```

## Deployment

`.github/workflows/pages-deploy.yml` builds and deploys to GitHub Pages on every push to `main`.
html-proofer gates the deploy, so run `make test` before pushing.

## Writing posts

Posts live in `_posts/YYYY-MM-DD-slug.md`. Front matter keys: `title`, `date` (with timezone offset),
`categories`, `tags`, `description` and optionally `image`. Tags must be lowercase. Images go in
`assets/` and are referenced as `/assets/<name>`.

Every post gets an AI-assistance note appended by `_plugins/ai-notice.rb`. Opt a post out with
`ai_assisted: false` in its front matter.

## License

This work is published under the [MIT](LICENSE) License.
