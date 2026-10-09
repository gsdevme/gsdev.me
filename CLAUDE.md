# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal blog for gsdev.me, built with Jekyll and the **Chirpy** theme (`jekyll-theme-chirpy` ~> 7.6, pulled in as a gem via the Gemfile). The repo is the Chirpy *starter*: only the files Jekyll cannot read from a theme gem live here (`_config.yml`, `_plugins`, `_tabs`, `index.html`, `_data`, `assets`). Layouts, includes and Sass come from the gem — locate them with `bundle info --path jekyll-theme-chirpy` rather than searching this repo.

## Commands

All scripts are run from the repo root and need Ruby + Bundler (`bundle install` first).

```bash
bash tools/run.sh                 # bundle exec jekyll s -l -H 127.0.0.1 (live reload)
bash tools/run.sh -p              # same, with JEKYLL_ENV=production
bash tools/run.sh -H 0.0.0.0      # bind to another host
bash tools/test.sh                # production build into _site, then html-proofer
```

`tools/test.sh` is the only test: it runs `htmlproofer _site --disable-external` and is the same check CI runs. There are no unit tests.

Docker alternative (`infrastructure/docker-compose.yaml`, `ruby:3.4` image, gems installed into the gitignored `vendor/bundle`):

```bash
make            # docker compose up: bundle install + live-reload server on http://localhost:4000
make test       # bundle install + tools/test.sh in a one-off container
make shell      # bash in a one-off container
make clean      # compose down + remove .bundle, vendor, _site, .jekyll-cache
```

The container runs as the host UID/GID (exported by the `Makefile`) with `userns_mode: keep-id`, which is required on this machine because `docker` is rootless Podman; generated files stay owned by your user.

## Deployment

`.github/workflows/pages-deploy.yml` builds and deploys to GitHub Pages on every push to `main`/`master` (ignoring `.gitignore`, `README.md`, `LICENSE`). It uses Ruby 3.4 (also pinned in `.ruby-version`), builds with `JEKYLL_ENV=production`, runs html-proofer, then publishes. A failing html-proofer check blocks the deploy, so run `tools/test.sh` before pushing. `CNAME` pins the custom domain.

The checkout uses `fetch-depth: 0` on purpose: `_plugins/posts-lastmod-hook.rb` shells out to `git log` to set `last_modified_at` on any post with more than one commit. A shallow clone would silently drop that metadata.

## Content conventions

- Posts go in `_posts/YYYY-MM-DD-slug.md`. Front matter uses `title`, `date` (with timezone offset), `categories: [Parent, Child]` and `tags: [...]`. Tag names must be lowercase (Chirpy convention). Layout, `comments`, `toc` and the `/posts/:title/` permalink are applied by `defaults` in `_config.yml`, so posts do not need to set them.
- `_tabs/*.md` are the sidebar pages; order is controlled by the `order` front-matter key. `archives`, `categories` and `tags` tabs are theme boilerplate and should normally be left alone.
- Images live flat in `assets/` and are referenced as `/assets/<name>`.
- `assets/lib` is a git submodule (chirpy-static-assets) that is **not** initialised and is not checked out in CI. The theme loads those assets from a CDN because `assets.self_host.enabled` is unset in `_config.yml`; only initialise the submodule and set that option together.
- `tools/`, `README.md` and `LICENSE` are in the `exclude` list of `_config.yml` and never reach the built site.
