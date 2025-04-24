# frozen_string_literal: true

# lib/editorjs_renderer/blocks/delimiter.rb
module EditorjsRenderer
  module Blocks
    # Delimiter block: renders a visual separator line (horizontal rule)
    #
    # Used to separate content sections, similar to <hr> or "---" in text.
    #
    # @example
    #   Delimiter.new({}).to_html
    #   # => '<hr class="delimiter-block">'
    #
    #   Delimiter.new({}).to_plain
    #   # => "---"
    class Delimiter < Base
      def to_html
        '<hr class="delimiter-block">'
      end

      def to_plain
        "---"
      end
    end
  end
end
