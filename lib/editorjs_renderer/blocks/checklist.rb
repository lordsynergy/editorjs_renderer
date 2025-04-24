# frozen_string_literal: true

# lib/editorjs_renderer/blocks/checklist.rb
module EditorjsRenderer
  module Blocks
    # Checklist block: renders a list of checkboxes (readonly)
    class Checklist < Base
      def to_html
        items = block_data["items"].map do |item|
          text = ERB::Util.html_escape(item["text"].to_s)
          checked_attr = item["checked"] ? " checked" : ""
          "<li><input type=\"checkbox\"#{checked_attr} disabled> #{text}</li>"
        end

        "<ul class=\"checklist-block\">#{items.join}</ul>"
      end

      def to_plain
        block_data["items"].map do |item|
          marker = item["checked"] ? "[x]" : "[ ]"
          "#{marker} #{item["text"]}"
        end.join("\n")
      end
    end
  end
end
