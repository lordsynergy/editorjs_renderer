# frozen_string_literal: true

# lib/editorjs_renderer/blocks/paragraph.rb
module EditorjsRenderer
  module Blocks
    # Paragraph block rendering logic.
    # Converts "paragraph" block data into a `<p>` HTML element and plain text string.
    #
    # Expects schema to define at least a "text" property in the data.
    #
    # @see EditorjsRenderer::Blocks::Base
    class Paragraph < Base
      def to_html
        "<p>#{ERB::Util.html_escape(block_data["text"])}</p>"
      end

      def to_plain
        block_data["text"].to_s
      end
    end
  end
end
