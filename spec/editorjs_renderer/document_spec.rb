# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Document do
  subject(:doc) { described_class.new(document_data) }

  let(:document_data) do
    file_path = File.expand_path("../fixtures/full_document.json", __dir__)
    JSON.parse(File.read(file_path))
  end

  describe "#render as HTML" do
    let(:html_output) { doc.render(format: :html) }

    it "renders header block" do
      expect(html_output).to include("<h2>Main title</h2>")
    end

    it "renders paragraph block" do
      expect(html_output).to include("Paragraph block")
    end

    it "renders table block" do
      expect(html_output).to include("<table")
    end

    it "renders spoiler block" do
      expect(html_output).to include("Click to reveal")
    end

    it "renders image block" do
      expect(html_output).to include("<img src=\"https://example.com/image.png\"")
    end

    it "renders list block" do
      expect(html_output).to include("<ol><li>First</li><li>Second</li></ol>")
    end

    it "renders attaches block" do
      expect(html_output).to include("<a href=\"https://example.com/report.pdf\"").and include("Report (120.6 KB)")
    end

    it "renders checklist block" do
      expect(html_output).to include("<ul class=\"checklist-block\">").and include("Buy milk")
    end
  end

  describe "#render as plain text" do
    let(:plain_output) { doc.render(format: :plain) }

    it "includes header text" do
      expect(plain_output).to include("Main title")
    end

    it "includes paragraph text" do
      expect(plain_output).to include("Paragraph block")
    end

    it "includes table text" do
      expect(plain_output).to include("Name | Age")
    end

    it "includes spoiler content" do
      expect(plain_output).to include("Spoiler content")
    end

    it "includes image caption in plain text" do
      expect(plain_output).to include("This is an image")
    end

    it "includes list items as ordered plain text" do
      expect(plain_output).to include("1. First\n2. Second")
    end

    it "includes attachment in plain text" do
      expect(plain_output).to include("[Attachment] Quarterly Report — https://example.com/report.pdf (120.6 KB)")
    end

    it "includes checklist items in plain text" do
      expect(plain_output).to include("[x] Buy milk").and include("[ ] Read book")
    end
  end

  describe "#render with unknown format" do
    it "raises an error" do
      expect { doc.render(format: :markdown) }.to raise_error(EditorjsRenderer::Errors::UnsupportedFormat)
    end
  end

  describe "#parse_blocks" do
    before { EditorjsRenderer.config.enabled_blocks = %w[paragraph] }

    it "skips unsupported blocks" do
      expect(doc.blocks.size).to eq(1)
    end
  end

  describe "validate" do
    let(:document_data) { { "blocks" => [] } }

    it "raises on invalid document structure" do
      expect { doc.blocks }.to raise_error(EditorjsRenderer::Errors::InvalidDocument)
    end
  end
end
