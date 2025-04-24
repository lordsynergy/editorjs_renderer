# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Header do
  let(:valid_data) { { "text" => "Section Title", "level" => 3 } }

  describe "#to_html" do
    it "renders the correct heading tag" do
      block = described_class.new(valid_data)
      expect(block.to_html).to eq("<h3>Section Title</h3>")
    end

    it "escapes HTML in text" do
      block = described_class.new("text" => "Hello <script>", "level" => 2)
      expect(block.to_html).to eq("<h2>Hello &lt;script&gt;</h2>")
    end
  end

  describe "#to_plain" do
    it "returns plain text content" do
      block = described_class.new(valid_data)
      expect(block.to_plain).to eq("Section Title")
    end
  end

  describe "validation" do
    it "raises if level is missing" do
      data = valid_data.dup.tap { |d| d.delete("level") }
      expect { described_class.new(data).to_html }.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end

    it "raises if text is missing" do
      data = valid_data.dup.tap { |d| d.delete("text") }
      expect { described_class.new(data).to_plain }.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end
  end
end
