# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::List do
  let(:block) { described_class.new("style" => "unordered", "items" => ["Item 1", "Item 2"]) }
  let(:block_two) { described_class.new("style" => "ordered", "items" => %w[First Second]) }

  describe "#to_html" do
    context "when style is unordered" do
      it "renders ul tag with list items" do
        expect(block.to_html).to eq("<ul><li>Item 1</li><li>Item 2</li></ul>")
      end
    end

    context "when style is ordered" do
      it "renders ol tag with list items" do
        expect(block_two.to_html).to eq("<ol><li>First</li><li>Second</li></ol>")
      end
    end
  end

  describe "#to_plain" do
    it "renders plain unordered list" do
      expect(block.to_plain).to eq("- Item 1\n- Item 2")
    end

    it "renders plain ordered list" do
      expect(block_two.to_plain).to eq("1. First\n2. Second")
    end
  end

  describe "validation" do
    it "raises error when style is missing" do
      expect do
        described_class.new("items" => ["Hello"]).to_html
      end.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end

    it "raises error when items are missing" do
      expect do
        described_class.new("style" => "unordered").to_html
      end.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end

    it "does not raise when both keys are present" do
      expect do
        described_class.new("style" => "unordered", "items" => ["Hi"]).to_html
      end.not_to raise_error
    end
  end
end
