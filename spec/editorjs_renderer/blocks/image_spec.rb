# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Image do
  let(:valid_data) do
    {
      "url" => "https://example.com/image.png",
      "caption" => "Cool image"
    }
  end
  let(:block) { described_class.new(valid_data) }

  describe "#to_html" do
    context "with caption" do
      it "renders <figure> tag" do
        expect(block.to_html).to include("<figure>")
      end

      it "renders <img> tag with url and alt" do
        expect(block.to_html).to include("<img src=\"https://example.com/image.png\" alt=\"Cool image\">")
      end

      it "renders <figcaption> tag" do
        expect(block.to_html).to include("<figcaption>Cool image</figcaption>")
      end
    end

    context "without caption" do
      let(:block) { described_class.new("url" => "https://example.com/image.png") }

      it "renders <img> tag only" do
        expect(block.to_html).to eq("<img src=\"https://example.com/image.png\" alt=\"\">")
      end
    end
  end

  describe "#to_plain" do
    it "returns caption prefixed by [Image]" do
      expect(block.to_plain).to eq("[Image] Cool image")
    end

    context "when caption is missing" do
      let(:block) { described_class.new("url" => "https://example.com/image.png") }

      it "returns only [Image]" do
        expect(block.to_plain).to eq("[Image]")
      end
    end
  end

  describe "validation" do
    context "when url is missing" do
      it "raises InvalidBlock on to_html" do
        expect { described_class.new({}).to_html }.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
      end

      it "raises InvalidBlock on to_plain" do
        expect { described_class.new({}).to_plain }.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
      end
    end

    context "when url is present" do
      it "does not raise on to_html" do
        expect { block.to_html }.not_to raise_error
      end

      it "does not raise on to_plain" do
        expect { block.to_plain }.not_to raise_error
      end
    end
  end
end
