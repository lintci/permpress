require 'spec_helper'
require 'stringio'

describe Permpress::Command do
  let(:file){'fake file.txt'}
  let(:command){Permpress::Command.new('cat', [file], %w(-b))}

  describe '#run' do
    let(:output){StringIO.new}

    context 'when command is successfully run' do
      let(:file){File.expand_path('../../fixtures/lint.txt', __FILE__)}

      it 'generates the expected output' do
        expect{command.run(output)}.to exit_successfully

        expect(output.string).to eq("     1\tlint\n")
      end
    end

    context 'when command is unsuccessfully run' do
      let(:command){Permpress::Command.new('this-command-does-not-exist', [file], %w(-b))}

      it 'generates the expected output' do
        expect{command.run(output)}.to_not exit_successfully

        expect(output.string).to eq("sh: this-command-does-not-exist: command not found\n")
      end
    end
  end

  describe '#command/#to_s' do
    it 'generates an executable command' do
      expect(command.command).to eq('cat -b fake\ file.txt 2>&1')
    end
  end
end
