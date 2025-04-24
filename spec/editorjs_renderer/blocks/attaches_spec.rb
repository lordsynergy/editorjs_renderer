# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Attaches do
  let(:data) do
    {
      "file" => { "url" => "https://example.com/report.pdf" },
      "title" => "Report Q1",
      "size" => 345_678
    }
  end
  let(:block) { described_class.new(data) }

  describe "#to_html" do
    it "wraps link in a <div> with class 'attachment-block'" do
      expect(block.to_html).to start_with('<div class="attachment-block">')
    end

    it "renders <a> tag with href and download attributes" do
      expect(block.to_html).to include('<a href="https://example.com/report.pdf" download>')
    end

    it "renders title inside the link" do
      expect(block.to_html).to include("Report Q1")
    end

    it "renders formatted size inside the link" do
      expect(block.to_html).to include(" (337.6 KB)")
    end

    it "closes the <div> tag" do
      expect(block.to_html).to end_with("</a></div>")
    end
  end

  describe "#to_plain" do
    it "returns formatted plain text with size" do
      expect(block.to_plain).to include("Report Q1 — https://example.com/report.pdf (337.6 KB)")
    end
  end

  describe "validation" do
    it "raises error when file is missing" do
      expect do
        described_class.new("title" => "Title").to_html
      end.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end

    it "does not raise when all required fields are present" do
      expect { block.to_html }.not_to raise_error
    end
  end
end
