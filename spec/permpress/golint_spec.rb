require 'spec_helper'

describe Permpress::GoLint do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    it 'executes command with expected arguments' do
      expect(Permpress::Command).to receive(:new).with(
        'fgt golint',
        %w(good.go bad.go),
        []
      ).and_return(instance_double(Permpress::Command, run: nil))

      Permpress::GoLint.start(['lint', 'good.go', 'bad.go'])
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.go', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['golint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:5:1: exported function Main should have comment or be unexported\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.go', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['golint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
