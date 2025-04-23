# frozen_string_literal: true

# lib/editorjs_renderer/renderers/plain_renderer.rb
module EditorjsRenderer
  module Renderers
    # Renders an array of block objects to plain text output.
    # Used for indexing, previews, or fallback content.
    module PlainRenderer
      def self.render(blocks)
        blocks.map(&:to_plain).join("\n")
      end
    end
  end
end
