# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorRails::Blocks::Table do
  let(:valid_data) do
    {
      "content" => [
        %w[Name Age],
        %w[Alice 30],
        %w[Bob 25]
      ]
    }
  end

  describe "#to_html" do
    subject(:block) { described_class.new(valid_data) }

    it "renders a <table> tag" do
      expect(block.to_html).to include("<table>")
    end

    it "renders table rows" do
      html = block.to_html
      expect(html.scan("<tr>").size).to eq(3)
    end

    it "renders table cells with data" do
      expect(block.to_html).to include("<td>Alice</td>").and include("<td>30</td>").and include("<td>Bob</td>")
    end
  end

  describe "#to_plain" do
    it "renders plain table text" do
      block = described_class.new(valid_data)
      expect(block.to_plain).to eq("Name | Age\nAlice | 30\nBob | 25")
    end
  end

  describe "validation" do
    it "raises if content is missing" do
      expect do
        described_class.new({}).to_html
      end.to raise_error(EditorRails::Errors::InvalidBlock, /is invalid/)
    end
  end
end
