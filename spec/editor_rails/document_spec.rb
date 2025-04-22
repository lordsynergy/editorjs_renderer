# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorRails::Document do
  let(:valid_data) do
    {
      "time" => "12345678",
      "blocks" => [
        { "type" => "paragraph", "data" => { "text" => "Hello <world>" } }
      ]
    }
  end

  describe "#render" do
    it "renders HTML safely" do
      doc = described_class.new(valid_data)
      expect(doc.render(format: :html)).to include("&lt;world&gt;")
    end

    it "renders plain text" do
      doc = described_class.new(valid_data)
      expect(doc.render(format: :plain)).to eq("Hello <world>")
    end

    it "raises on unknown format" do
      doc = described_class.new(valid_data)
      expect { doc.render(format: :markdown) }.to raise_error(EditorRails::Errors::UnsupportedFormat)
    end
  end

  describe "#parse_blocks" do
    let(:data_with_unknown_block) do
      valid_data.merge("blocks" => [
                         { "type" => "unknown", "data" => {} },
                         { "type" => "paragraph", "data" => { "text" => "Hi" } }
                       ])
    end

    before { EditorRails.config.enabled_blocks = %w[paragraph] }

    it "skips unsupported blocks" do
      doc = described_class.new(data_with_unknown_block)
      expect(doc.blocks.size).to eq(1)
    end
  end

  describe "validate" do
    it "raises on invalid document structure" do
      expect do
        described_class.new({ "blocks" => [] })
      end.to raise_error(EditorRails::Errors::InvalidDocument)
    end
  end
end
