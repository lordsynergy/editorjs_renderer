# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorRails::Blocks::Base do
  let(:schema_path) { File.join(EditorRails.config.schemas_path, "dummy_block.yml") }
  let(:dummy_block_class) do
    Class.new(described_class) do
      def render; end
      def plain; end
    end
  end

  before do
    File.write(schema_path, <<~YAML)
      required:
        - foo
    YAML

    stub_const("EditorRails::Blocks::DummyBlock", dummy_block_class)
  end

  after { FileUtils.rm_f(schema_path) }

  describe "#initialize and validation" do
    context "when schema file is missing" do
      let(:missing_block_class) do
        Class.new(described_class) do
          def render; end
          def plain; end
        end
      end

      it "raises an InvalidBlock error" do
        stub_const("EditorRails::Blocks::MissingSchemaBlock", missing_block_class)

        expect do
          EditorRails::Blocks::MissingSchemaBlock.new("foo" => "bar")
        end.to raise_error(EditorRails::Errors::InvalidBlock, /Missing schema file/)
      end
    end

    context "when required field is missing" do
      it "raises an InvalidBlock error" do
        expect do
          EditorRails::Blocks::DummyBlock.new({})
        end.to raise_error(EditorRails::Errors::InvalidBlock, /is invalid/)
      end
    end

    context "when required fields are present" do
      it "does not raise" do
        expect do
          EditorRails::Blocks::DummyBlock.new("foo" => "bar")
        end.not_to raise_error
      end
    end
  end

  describe "#render" do
    it "raises NotImplementedError by default" do
      base = described_class.allocate
      expect { base.render }.to raise_error(NotImplementedError)
    end
  end

  describe "#plain" do
    it "raises NotImplementedError by default" do
      base = described_class.allocate
      expect { base.plain }.to raise_error(NotImplementedError)
    end
  end
end
