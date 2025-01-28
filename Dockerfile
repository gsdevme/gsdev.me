FROM jekyll/jekyll

RUN gem install bundler


docker run -it --rm \
--volume="$(pwd):/srv/jekyll" \
    -p 4000:4000 jekyll/jekyll \
    jekyll serve
