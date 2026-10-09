# frozen_string_literal: true

# Appends an AI-assistance disclosure to the end of every post.
#
# The notice is a Chirpy `prompt-info` blockquote linking to the
# "How I use AI" section of the About page. It is added in a :pre_render
# hook so it goes through Markdown conversion with the rest of the post.
#
# Opt out per post with `ai_assisted: false` in the front matter.
#
# The HTML-comment MARKER makes the hook idempotent: `jekyll serve` can
# re-render the same post object, and the marker stops the notice from
# being appended more than once.
module AiNotice
  MARKER = "<!-- ai-notice -->"

  NOTICE = <<~MD

    #{MARKER}
    > I wrote this post with help from AI tools (Claude, Codex). I review, edit and check everything before publishing. [How I use AI](/about/#how-i-use-ai)
    {: .prompt-info }
  MD
end

Jekyll::Hooks.register :posts, :pre_render do |post, _payload|
  next if post.data["ai_assisted"] == false
  next if post.content.include?(AiNotice::MARKER)

  post.content = post.content.rstrip + "\n" + AiNotice::NOTICE
end
