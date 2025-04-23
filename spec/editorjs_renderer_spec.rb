# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorjsRenderer do
  describe "VERSION" do
    it "is defined as a String" do
      expect(described_class::VERSION).to be_a(String)
    end

    it "is not empty" do
      expect(described_class::VERSION).not_to be_empty
    end
  end

  describe ".css_name_prefix" do
    around do |example|
      original_prefix = described_class.css_name_prefix
      example.run
      described_class.css_name_prefix = original_prefix
    end

    it "returns the default CSS prefix" do
      expect(described_class.css_name_prefix).to eq("editor_js--")
    end

    it "allows setting a custom CSS prefix" do
      described_class.css_name_prefix = "custom--"
      expect(described_class.css_name_prefix).to eq("custom--")
    end
  end
end
