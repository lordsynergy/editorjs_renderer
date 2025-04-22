# frozen_string_literal: true

# lib/editor_rails/blocks/paragraph.rb
module EditorRails
  module Blocks
    # Paragraph block rendering logic.
    # Converts "paragraph" block data into a `<p>` HTML element and plain text string.
    #
    # Expects schema to define at least a "text" property in the data.
    #
    # @see EditorRails::Blocks::Base
    class Paragraph < Base
      def render
        "<p>#{ERB::Util.html_escape(data["text"])}</p>"
      end

      def plain
        data["text"].to_s
      end
    end
  end
end
