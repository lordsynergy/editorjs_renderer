# frozen_string_literal: true

# lib/editorjs_renderer/blocks/base.rb
module EditorjsRenderer
  module Blocks
    # Abstract base class for all EditorjsRenderer blocks.
    # Implements schema validation using JSON Schemer and requires subclasses
    # to implement `render` (HTML) and `plain` (text) output methods.
    #
    # @abstract
    class Base
      def initialize(block_data)
        @block_data = block_data
      end

      def to_html
        raise NotImplementedError
      end

      def to_plain
        raise NotImplementedError
      end

      def block_data
        validate!
        @block_data
      end

      private

      def validate!
        raise Errors::InvalidBlock, "Anonymous block class has no name" unless self.class.name

        schema = schema_for(self.class.name)
        EditorjsRenderer::SchemaValidator.validate!(
          data: @block_data,
          schema: schema,
          error_class: Errors::InvalidBlock,
          context: self.class.name
        )
      end

      def schema_for(class_name)
        schema_file = "#{class_name.demodulize.underscore}.yml"
        schema_path = File.join(EditorjsRenderer.config.schemas_path, schema_file)
        raise Errors::InvalidBlock, "Missing schema file for #{class_name}" unless File.exist?(schema_path)

        YAML.load_file(schema_path)
      end
    end
  end
end
