# frozen_string_literal: true

# lib/editor_rails/renderers/html_renderer.rb
module EditorRails
  module Renderers
    # Renders an array of block objects to HTML output.
    # Used internally by `EditorRails::Document`.
    module HtmlRenderer
      def self.render(blocks)
        blocks.map(&:render).join("\n").html_safe
      end
    end
  end
end
