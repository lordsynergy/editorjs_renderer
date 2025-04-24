# frozen_string_literal: true

# lib/editorjs_renderer/blocks/code.rb
module EditorjsRenderer
  module Blocks
    # Code block: renders a block of code inside <pre><code>
    class Code < Base
      def to_html
        code = ERB::Util.html_escape(block_data["code"].to_s)
        "<pre><code>#{code}</code></pre>"
      end

      def to_plain
        block_data["code"].to_s
      end
    end
  end
end
