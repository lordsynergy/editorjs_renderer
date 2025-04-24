# frozen_string_literal: true

# lib/editorjs_renderer/blocks/list.rb
module EditorjsRenderer
  module Blocks
    # List block: renders a list as <ul>/<ol> with <li> elements.
    #
    # Example block data:
    # {
    #   "style": "ordered",
    #   "items": ["First", "Second"]
    # }
    #
    # Renders to:
    # <ol><li>First</li><li>Second</li></ol>
    #
    # Or in plain text:
    # 1. First
    # 2. Second
    class List < Base
      def to_html
        style = block_data["style"] == "ordered" ? "ol" : "ul"
        items = block_data["items"].map do |item|
          "<li>#{ERB::Util.html_escape(item)}</li>"
        end
        "<#{style}>#{items.join}</#{style}>"
      end

      def to_plain
        if block_data["style"] == "ordered"
          block_data["items"].each_with_index.map { |item, i| "#{i + 1}. #{item}" }.join("\n")
        else
          block_data["items"].map { |item| "- #{item}" }.join("\n")
        end
      end
    end
  end
end
