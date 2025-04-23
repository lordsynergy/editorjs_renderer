# frozen_string_literal: true

# lib/editor_rails/blocks/table.rb
module EditorRails
  module Blocks
    # Table block rendering logic.
    # Converts a 2D array into HTML <table> and plain text.
    class Table < Base
      def to_html
        rows = block_data["content"].map do |row|
          cells = row.map { |cell| "<td>#{ERB::Util.html_escape(cell)}</td>" }.join
          "<tr>#{cells}</tr>"
        end.join

        "<table>#{rows}</table>"
      end

      def to_plain
        block_data["content"].map { |row| row.join(" | ") }.join("\n")
      end
    end
  end
end
