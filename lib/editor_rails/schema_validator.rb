# frozen_string_literal: true

# lib/editor_rails/schema_validator.rb
module EditorRails
  # Provides schema validation using JSON Schema via the `json_schemer` gem.
  # This module is used by EditorRails::Document and block classes to validate
  # structure and content of incoming EditorJS data against YAML-defined schemas.
  #
  # @api internal
  module SchemaValidator
    # Validates the given data against the provided JSON schema.
    #
    # @param params [Hash] a hash of named arguments:
    #   - :data [Hash] the data to validate
    #   - :schema [Hash] the JSON schema
    #   - :error_class [Class<StandardError>] class to raise if validation fails
    #   - :context [String] optional name or description to use in error messages
    #
    # @raise [StandardError] instance of provided error_class with detailed message
    #
    # @example
    #   EditorRails::SchemaValidator.validate!(
    #     data: { "time" => 123456, "blocks" => [] },
    #     schema: YAML.load_file("schema.yml"),
    #     error_class: EditorRails::Errors::InvalidDocument,
    #     context: "EditorJS Document"
    #   )
    def self.validate!(params)
      data, schema, error_class, context = extract_params(params)

      errors = JSONSchemer.schema(schema).validate(data).to_a
      return if errors.empty?

      message = formatted_message(errors, context)
      raise error_class, message
    end

    # Extracts and validates required parameters from the input hash.
    #
    # @param params [Hash] input hash with required keys
    # @return [Array] extracted arguments in order: data, schema, error_class, context
    #
    # @raise [KeyError] if any required keys are missing
    def self.extract_params(params)
      data        = params.fetch(:data)
      schema      = params.fetch(:schema)
      error_class = params.fetch(:error_class)
      context     = params.fetch(:context, "(document)")

      [data, schema, error_class, context]
    end

    # Builds a human-readable error message from validation errors.
    #
    # @param errors [Array<Hash>] list of validation error hashes
    # @param context [String] the name of the context (block class or document)
    # @return [String] formatted error message
    def self.formatted_message(errors, context)
      error_messages = errors.map do |err|
        location = err["data_pointer"].presence || context
        detail = err["message"].presence || "is invalid"
        "#{location}: #{detail}"
      end

      "#{context} validation failed: #{error_messages.join(", ")}"
    end
  end
end
