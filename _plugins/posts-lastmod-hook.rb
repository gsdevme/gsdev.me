#!/usr/bin/env ruby
#
# Sets `last_modified_at` on any post with more than one commit, using the
# date of its latest commit. Posts that set `last_modified_at` explicitly in
# their front matter are left alone, so cosmetic edits need not surface as
# an update.

Jekyll::Hooks.register :posts, :post_init do |post|
  next if post.data.key?("last_modified_at")

  commit_num = `git rev-list --count HEAD "#{post.path}"`

  if commit_num.to_i > 1
    lastmod_date = `git log -1 --pretty="%ad" --date=iso "#{post.path}"`
    post.data["last_modified_at"] = lastmod_date
  end
end
