# frozen_string_literal: true

# lib/editor_rails/config.rb
module EditorRails
  # Configuration object for EditorRails.
  # Used to set block schemas path and list of enabled block types.
  #
  # @see EditorRails.configure
  class Config
    attr_accessor :schemas_path, :enabled_blocks

    def initialize
      @schemas_path = File.join(EditorRails.root, "lib", "editor_rails", "schemas")
      @enabled_blocks = %w[paragraph]
    end
  end
end
