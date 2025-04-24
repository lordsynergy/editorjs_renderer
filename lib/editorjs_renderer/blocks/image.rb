# frozen_string_literal: true

# lib/editorjs_renderer/blocks/image.rb
module EditorjsRenderer
  module Blocks
    # Image block: renders an <img> tag with optional caption
    class Image < Base
      def to_html
        url = ERB::Util.html_escape(block_data["url"])
        caption = ERB::Util.html_escape(block_data["caption"].to_s)
        figure = "<img src=\"#{url}\" alt=\"#{caption}\">"
        caption.empty? ? figure : "<figure>#{figure}<figcaption>#{caption}</figcaption></figure>"
      end

      def to_plain
        caption = block_data["caption"].to_s
        "[Image] #{caption}".strip
      end
    end
  end
end
