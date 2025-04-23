# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Spoiler do
  let(:valid_block_data) do
    {
      "caption" => "Read more",
      "content" => {
        "blocks" => [
          {
            "id" => "inner1",
            "type" => "paragraph",
            "data" => { "text" => "Hidden content" },
            "tunes" => {}
          }
        ]
      }
    }
  end

  describe "#to_html" do
    subject(:block) { described_class.new(valid_block_data) }

    it "renders a <details> tag" do
      expect(block.to_html).to include("<details>")
    end

    it "renders a <summary> tag with the caption" do
      expect(block.to_html).to include("<summary>Read more</summary>")
    end

    it "renders inner paragraph block" do
      expect(block.to_html).to include("<p>Hidden content</p>")
    end
  end

  describe "#to_plain" do
    subject(:block) { described_class.new(valid_block_data) }

    it "renders caption and plain content" do
      expect(block.to_plain).to eq("Read more: Hidden content")
    end
  end

  describe "validation" do
    it "raises if caption is missing" do
      data = valid_block_data.deep_dup
      data.delete("caption")

      expect do
        described_class.new(data).to_html
      end.to raise_error(EditorjsRenderer::Errors::InvalidBlock, /is invalid/)
    end

    it "raises if content.blocks is missing" do
      data = valid_block_data.deep_dup
      data["content"].delete("blocks")

      expect do
        described_class.new(data).to_plain
      end.to raise_error(EditorjsRenderer::Errors::InvalidBlock, /is invalid/)
    end
  end

  describe "nested spoilers" do
    let(:nested_data) do
      {
        "caption" => "Outer",
        "content" => {
          "blocks" => [
            {
              "id" => "nested1",
              "type" => "spoiler",
              "data" => {
                "caption" => "Inner",
                "content" => {
                  "blocks" => [
                    {
                      "id" => "inner-p",
                      "type" => "paragraph",
                      "data" => { "text" => "Deeply hidden" },
                      "tunes" => {}
                    }
                  ]
                },
                "tunes" => {}
              },
              "tunes" => {}
            }
          ]
        }
      }
    end

    let(:block) { described_class.new(nested_data) }

    describe "#to_html" do
      it "renders outer summary" do
        expect(block.to_html).to include("<summary>Outer</summary>")
      end

      it "renders inner summary" do
        expect(block.to_html).to include("<summary>Inner</summary>")
      end

      it "renders deeply hidden paragraph" do
        expect(block.to_html).to include("<p>Deeply hidden</p>")
      end
    end

    describe "#to_plain" do
      it "renders nested plain text with all captions" do
        expect(block.to_plain).to eq("Outer: Inner: Deeply hidden")
      end
    end
  end
end
