# frozen_string_literal: true

# lib/editorjs_renderer/blocks/attaches.rb
module EditorjsRenderer
  module Blocks
    # Attaches block: renders a file download link with title and optional size.
    class Attaches < Base
      def to_html
        url = ERB::Util.html_escape(block_data.dig("file", "url"))
        title = ERB::Util.html_escape(block_data["title"].to_s)
        size = block_data["size"]

        size_str = size ? " (#{format_size(size)})" : ""
        "<div class=\"attachment-block\"><a href=\"#{url}\" download>#{title}#{size_str}</a></div>"
      end

      def to_plain
        url = block_data.dig("file", "url")
        title = block_data["title"].to_s
        size = block_data["size"]
        size_str = size ? " (#{format_size(size)})" : ""
        "[Attachment] #{title} — #{url}#{size_str}".strip
      end

      private

      def format_size(bytes)
        return unless bytes.respond_to?(:to_f) && bytes.to_f.positive?

        kb = bytes.to_f / 1024
        mb = kb / 1024
        return "#{format("%.1f", mb)} MB" if mb >= 1

        "#{format("%.1f", kb)} KB"
      end
    end
  end
end
