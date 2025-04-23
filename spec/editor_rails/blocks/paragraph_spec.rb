# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorRails::Blocks::Paragraph do
  let(:block) { described_class.new("text" => "Hello <world>") }

  describe "#to_html" do
    it "wraps text in <p> and escapes HTML" do
      expect(block.to_html).to eq("<p>Hello &lt;world&gt;</p>")
    end
  end

  describe "#to_plain" do
    it "returns the text field content as plain string" do
      expect(block.to_plain).to eq("Hello <world>")
    end
  end

  describe "validation" do
    context "when required key is missing" do
      it "raises InvalidBlock when calling to_html" do
        expect { described_class.new({}).to_html }.to raise_error(EditorRails::Errors::InvalidBlock)
      end

      it "raises InvalidBlock when calling to_plain" do
        expect { described_class.new({}).to_plain }.to raise_error(EditorRails::Errors::InvalidBlock)
      end
    end

    context "when required key is present" do
      it "does not raise when calling #to_html" do
        expect { block.to_html }.not_to raise_error
      end

      it "does not raise when calling #to_plain" do
        expect { block.to_plain }.not_to raise_error
      end
    end
  end
end
