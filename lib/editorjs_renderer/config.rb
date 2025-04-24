# frozen_string_literal: true

# lib/editorjs_renderer/config.rb
module EditorjsRenderer
  # Configuration object for EditorjsRenderer.
  # Used to set block schemas path and list of enabled block types.
  #
  # @see EditorjsRenderer.configure
  class Config
    attr_accessor :schemas_path, :enabled_blocks

    def initialize
      @schemas_path = File.join(EditorjsRenderer.root, "lib", "editorjs_renderer", "schemas")
      @enabled_blocks = %w[paragraph spoiler table header image list attaches]
    end
  end
end
