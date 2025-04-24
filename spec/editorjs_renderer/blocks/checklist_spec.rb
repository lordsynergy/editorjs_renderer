# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer::Blocks::Checklist do
  let(:block) do
    described_class.new(
      "items" => [
        { "text" => "First task", "checked" => true },
        { "text" => "Second task", "checked" => false }
      ]
    )
  end

  describe "#to_html" do
    it "renders item inside <li>" do
      expect(block.to_html).to include("<li><input type=\"checkbox\" checked disabled> First task</li>")
    end

    it "renders checked checkbox in HTML" do
      expect(block.to_html).to include('<input type="checkbox" checked disabled>')
    end

    it "renders unchecked checkbox in HTML" do
      expect(block.to_html).to include('<input type="checkbox" disabled>')
    end

    it "wraps items in checklist-block list" do
      expect(block.to_html).to start_with('<ul class="checklist-block">')
    end
  end

  describe "#to_plain" do
    it "renders checklist as plain text" do
      expect(block.to_plain).to eq("[x] First task\n[ ] Second task")
    end
  end

  describe "validation" do
    it "raises when items are missing" do
      expect do
        described_class.new({}).to_html
      end.to raise_error(EditorjsRenderer::Errors::InvalidBlock)
    end
  end
end
