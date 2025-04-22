# frozen_string_literal: true

# lib/editor_rails/errors.rb
# Contains custom error classes used throughout EditorRails.
module EditorRails
  # Custom error namespace for all EditorRails-specific exceptions.
  module Errors
    # Raised when the EditorJS document structure is invalid.
    class InvalidDocument < StandardError; end

    # Raised when the requested output format (e.g., :html, :plain) is not supported.
    class UnsupportedFormat < StandardError; end

    # Raised when a block type is not listed in the enabled blocks.
    class UnsupportedBlockType < StandardError; end

    # Raised when a block fails schema validation or its schema file is missing.
    class InvalidBlock < StandardError; end
  end
end
