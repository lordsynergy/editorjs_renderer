# frozen_string_literal: true

# lib/editor_rails/blocks/base.rb
module EditorRails
  module Blocks
    # Abstract base class for all EditorRails blocks.
    # Implements schema validation using JSON Schemer and requires subclasses
    # to implement `render` (HTML) and `plain` (text) output methods.
    #
    # @abstract
    class Base
      attr_reader :data

      def initialize(data)
        @data = data
        validate!
      end

      def render
        raise NotImplementedError
      end

      def plain
        raise NotImplementedError
      end

      def validate!
        raise Errors::InvalidBlock, "Anonymous block class has no name" unless self.class.name

        schema = schema_for(self.class.name)
        EditorRails::SchemaValidator.validate!(
          data: data,
          schema: schema,
          error_class: Errors::InvalidBlock,
          context: self.class.name
        )
      end

      private

      def schema_for(class_name)
        schema_file = "#{class_name.demodulize.underscore}.yml"
        schema_path = File.join(EditorRails.config.schemas_path, schema_file)
        raise Errors::InvalidBlock, "Missing schema file for #{class_name}" unless File.exist?(schema_path)

        YAML.load_file(schema_path)
      end
    end
  end
end
