# frozen_string_literal: true

# lib/editorjs_renderer/document.rb
module EditorjsRenderer
  # Represents an EditorJS document parsed from a Hash or JSON structure.
  # Validates the document structure and renders its blocks using configured renderers.
  #
  # @example Rendering HTML
  #   document = EditorjsRenderer::Document.new(editorjs_data)
  #   document.render(format: :html)
  class Document
    def initialize(editorjs_data)
      @editorjs_data = editorjs_data
      @blocks = nil
    end

    def render(format: :html)
      renderer_for(format).render(blocks)
    end

    def blocks
      validate!
      @blocks ||= parse_blocks(@editorjs_data["blocks"])
    end

    private

    def parse_blocks(blocks_data)
      blocks_data.filter_map { build_block(it) }
    end

    def build_block(block_data)
      klass = block_class(block_data["type"])
      klass.new(block_data["data"])
    rescue StandardError => e
      EditorjsRenderer.logger.warn("Invalid block skipped: #{e.message}")
      nil
    end

    def block_class(type)
      unless EditorjsRenderer.config.enabled_blocks.include?(type)
        raise Errors::UnsupportedBlockType, "Unsupported block type: #{type}"
      end

      EditorjsRenderer::Blocks.const_get(type.camelize)
    end

    def renderer_for(format)
      case format
      when :html then EditorjsRenderer::Renderers::HtmlRenderer
      when :plain then EditorjsRenderer::Renderers::PlainRenderer
      else raise Errors::UnsupportedFormat, "Unsupported format: #{format}"
      end
    end

    def validate!
      schema = YAML.load_file(File.join(EditorjsRenderer.config.schemas_path, "document.yml"))
      EditorjsRenderer::SchemaValidator.validate!(
        data: @editorjs_data,
        schema: schema,
        error_class: Errors::InvalidDocument,
        context: "(document)"
      )
    end
  end
end
