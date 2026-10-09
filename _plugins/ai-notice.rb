# frozen_string_literal: true

# Appends an AI-assistance disclosure to the end of every post.
#
# The notice is a Chirpy `prompt-info` blockquote linking to the
# "How I use AI" section of the About page. It is added in a :pre_render
# hook, so it goes through Liquid and Markdown conversion with the rest of
# the post; Jekyll re-reads each post from disk per build, so the hook sees
# the original content every time.
#
# Opt out per post with `ai_assisted: false` in the front matter.
module AiNotice
  NOTICE = <<~MD

    > I wrote this post with help from AI tools (Claude, Codex). I review, edit and check everything before publishing. [How I use AI]({{ '/about/#how-i-use-ai' | relative_url }})
    {: .prompt-info }
  MD
end

Jekyll::Hooks.register :posts, :pre_render do |post, _payload|
  next if post.data["ai_assisted"] == false

  post.content = post.content.rstrip + "\n" + AiNotice::NOTICE
end
