# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorRails::Blocks::Paragraph do
  describe "#to_html" do
    it "wraps text in <p> and escapes HTML" do
      block = described_class.new("text" => "Hello <world>")
      expect(block.to_html).to eq("<p>Hello &lt;world&gt;</p>")
    end
  end

  describe "#to_plain" do
    it "returns raw text" do
      block = described_class.new("text" => "Hello <world>")
      expect(block.to_plain).to eq("Hello <world>")
    end
  end

  describe "validation" do
    it "raises if required key is missing" do
      expect do
        described_class.new({})
      end.to raise_error(EditorRails::Errors::InvalidBlock, /is invalid/)
    end
  end
end
