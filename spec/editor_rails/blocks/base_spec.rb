# frozen_string_literal: true

require "spec_helper"

RSpec.describe EditorRails::Blocks::Base do
  let(:schema_path) { File.join(EditorRails.config.schemas_path, "dummy_block.yml") }
  let(:dummy_block_class) do
    Class.new(described_class) do
      def to_html
        block_data["foo"]
      end

      def to_plain
        block_data["foo"]
      end
    end
  end

  before do
    File.write(schema_path, <<~YAML)
      type: object
      required:
        - foo
      properties:
        foo:
          type: string
    YAML

    stub_const("EditorRails::Blocks::DummyBlock", dummy_block_class)
  end

  after { FileUtils.rm_f(schema_path) }

  describe "abstract interface" do
    let(:base) { described_class.allocate }

    it "raises NotImplementedError on #to_html" do
      expect { base.to_html }.to raise_error(NotImplementedError)
    end

    it "raises NotImplementedError on #to_plain" do
      expect { base.to_plain }.to raise_error(NotImplementedError)
    end
  end

  describe "validation behavior in subclasses" do
    context "when schema file is missing" do
      let(:broken_class) do
        Class.new(described_class) do
          def to_html
            block_data["x"]
          end

          def to_plain
            block_data["x"]
          end
        end
      end

      it "raises InvalidBlock when schema is missing" do
        stub_const("EditorRails::Blocks::BrokenBlock", broken_class)
        block = EditorRails::Blocks::BrokenBlock.new({ "x" => 1 })

        expect { block.to_html }.to raise_error(EditorRails::Errors::InvalidBlock, /Missing schema file/)
      end
    end

    context "when required field is missing" do
      it "raises InvalidBlock error on usage" do
        block = EditorRails::Blocks::DummyBlock.new({})
        expect { block.to_html }.to raise_error(EditorRails::Errors::InvalidBlock, /is invalid/)
      end
    end

    context "when required fields are present" do
      it "does not raise" do
        block = EditorRails::Blocks::DummyBlock.new("foo" => "bar")
        expect { block.to_html }.not_to raise_error
      end
    end
  end
end
