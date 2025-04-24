# frozen_string_literal: true

# lib/editorjs_renderer/blocks/header.rb
module EditorjsRenderer
  module Blocks
    # Header block renders a heading tag (<h1>–<h6>) based on level.
    #
    # @example
    #   data = { "text" => "Title", "level" => 2 }
    #   Header.new(data).to_html # => "<h2>Title</h2>"
    class Header < Base
      def to_html
        level = data["level"].to_i.clamp(1, 6)
        text = ERB::Util.html_escape(block_data["text"])
        "<h#{level}>#{text}</h#{level}>"
      end

      def to_plain
        block_data["text"].to_s
      end
    end
  end
end
