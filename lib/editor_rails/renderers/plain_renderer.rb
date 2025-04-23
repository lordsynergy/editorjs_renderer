# frozen_string_literal: true

# lib/editor_rails/renderers/plain_renderer.rb
module EditorRails
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
