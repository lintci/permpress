require 'spec_helper'

describe Permpress::JSONLint do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    it 'executes command with expected arguments' do
      expect(Permpress::Command).to receive(:new).with(
        'durable-json-lint',
        %w(good.json bad.json),
        ['--format', '{{file}}:{{line}}:{{column}}:::error:{{{description}}}']
      ).and_return(instance_double(Permpress::Command, run: nil))

      Permpress::JSONLint.start(['lint', 'good.json', 'bad.json'])
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.json', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['jsonlint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:2:2:::error:Json strings must use double quotes\n"\
          "#{file}:3:2:::error:Keys must be double quoted in Json. Did you mean \"not\"?\n"\
          "#{file}:3:7:::error:Invalid Json number\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.json', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['jsonlint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
