# frozen_string_literal: true

# lib/editor_rails/blocks/spoiler.rb
module EditorRails
  module Blocks
    # Spoiler block rendering logic.
    #
    # This block renders collapsible content using <details> and <summary> HTML tags.
    # It can contain nested EditorJS blocks, including other Spoiler blocks.
    #
    # Expects the following structure:
    # {
    #   "caption": "Title",
    #   "content": {
    #     "blocks": [ ... ]
    #   }
    # }
    #
    # @example HTML output
    #   <details>
    #     <summary>Title</summary>
    #     ...nested block HTML...
    #   </details>
    #
    # @example Plain text output
    #   Title: Nested text...
    #
    # @see EditorRails::Blocks::Base
    class Spoiler < Base
      def to_html
        caption = ERB::Util.html_escape(block_data["caption"])
        content_blocks = block_data.dig("content", "blocks") || []
        inner_doc = Document.new("blocks" => content_blocks, "time" => Time.now.to_i.to_s)
        "<details><summary>#{caption}</summary>#{inner_doc.render}</details>"
      end

      def to_plain
        content_blocks = block_data.dig("content", "blocks") || []
        inner_doc = Document.new("blocks" => content_blocks, "time" => Time.now.to_i.to_s)
        "#{block_data["caption"]}: #{inner_doc.render(format: :plain)}"
      end
    end
  end
end
