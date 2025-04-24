# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Delimiter do
  let(:block) { described_class.new({}) }

  describe "#to_html" do
    it "renders horizontal rule with class" do
      expect(block.to_html).to eq('<hr class="delimiter-block">')
    end
  end

  describe "#to_plain" do
    it "renders plain delimiter" do
      expect(block.to_plain).to eq("---")
    end
  end

  describe "validation" do
    it "does not raise error on empty data" do
      expect { block.to_html }.not_to raise_error
    end

    it "does not raise error on to_plain" do
      expect { block.to_plain }.not_to raise_error
    end
  end
end
