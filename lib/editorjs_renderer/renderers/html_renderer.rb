# frozen_string_literal: true

# lib/editorjs_renderer/renderers/html_renderer.rb
module EditorjsRenderer
  module Renderers
    # Renders an array of block objects to HTML output.
    # Used internally by `EditorjsRenderer::Document`.
    module HtmlRenderer
      def self.render(blocks)
        blocks.map(&:to_html).join("\n").html_safe
      end
    end
  end
end
