require 'spec_helper'

describe Permpress::PyLint do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'pylint',
          %w(good.py bad.py),
          %w(
            -r no
            --msg-template "{abspath}:{line}:{column}::{symbol}:{category}:{msg}"
            --rcfile pylint.config
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::PyLint.start(['lint', '--config', 'pylint.config', 'good.py', 'bad.py'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'pylint',
          %w(good.py bad.py),
          %w(
            -r no
            --msg-template "{abspath}:{line}:{column}::{symbol}:{category}:{msg}"
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::PyLint.start(['lint', 'good.py', 'bad.py'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.py', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['pylint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "No config file found, using default configuration\n"\
          "************* Module bad\n"\
          "#{file}:1:0::missing-docstring:convention:Missing module docstring\n"\
          "#{file}:1:0::missing-docstring:convention:Missing function docstring\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.py', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['pylint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq("No config file found, using default configuration\n")
      end
    end
  end
end
