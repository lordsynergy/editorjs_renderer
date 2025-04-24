# frozen_string_literal: true

# lib/editorjs_renderer.rb
require "yaml"
require "active_support/all"
require "logger"
require "json_schemer"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

# EditorjsRenderer provides rendering and configuration logic for EditorJS-compatible
# data in Ruby applications. It allows transforming structured block-based data
# into HTML and plain text formats.
#
# You can configure enabled blocks and schema paths using `.configure`.
#
# @example Basic usage
#   EditorjsRenderer.configure do |config|
#     config.enabled_blocks = %w[paragraph]
#   end
module EditorjsRenderer
  # Base error class for all EditorjsRenderer-specific exceptions.
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
      @logger ||= Logger.new($stdout, progname: "EditorjsRenderer", level: Logger::INFO)
    end

    def css_name_prefix
      @css_name_prefix ||= "editor_js--"
    end
  end
end
