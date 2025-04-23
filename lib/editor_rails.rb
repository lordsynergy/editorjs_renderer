# frozen_string_literal: true

# lib/editor_rails.rb
require "yaml"
require "active_support/all"
require "logger"
require "json_schemer"

# EditorRails provides rendering and configuration logic for EditorJS-compatible
# data in Ruby applications. It allows transforming structured block-based data
# into HTML and plain text formats.
#
# You can configure enabled blocks and schema paths using `.configure`.
#
# @example Basic usage
#   EditorRails.configure do |config|
#     config.enabled_blocks = %w[paragraph]
#   end
module EditorRails
  # Base error class for all EditorRails-specific exceptions.
  # All library-level exceptions should inherit from this class.
  class Error < StandardError; end

  class << self
    attr_writer :css_name_prefix, :logger

    def root
      File.expand_path("..", __dir__)
    end

    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

    def logger
      @logger ||= Logger.new($stdout, progname: "EditorRails", level: Logger::INFO)
    end

    def css_name_prefix
      @css_name_prefix ||= "editor_js--"
    end
  end
end

require_relative "editor_rails/errors"
require_relative "editor_rails/config"
require_relative "editor_rails/document"
require_relative "editor_rails/renderers/html_renderer"
require_relative "editor_rails/renderers/plain_renderer"
require_relative "editor_rails/blocks/base"
require_relative "editor_rails/blocks/paragraph"
require_relative "editor_rails/blocks/spoiler"
require_relative "editor_rails/blocks/table"
require_relative "editor_rails/version"
require_relative "editor_rails/schema_validator"
