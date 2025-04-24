# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Code do
  let(:block) { described_class.new("code" => "puts 'Hello, world!'") }

  describe "#to_html" do
    it "wraps code in <pre><code> and escapes HTML" do
      expect(block.to_html).to eq("<pre><code>puts &#39;Hello, world!&#39;</code></pre>")
    end
  end

  describe "#to_plain" do
    it "returns code as plain string" do
      expect(block.to_plain).to eq("puts 'Hello, world!'")
    end
  end

  describe "validation" do
    it "raises when code is missing" do
      expect { described_class.new({}).to_html }.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end
  end
end
