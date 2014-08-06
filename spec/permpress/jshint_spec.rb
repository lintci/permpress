require 'spec_helper'

describe Permpress::JSHint do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'jshint',
          %w(good.js bad.js),
          %W(
            --reporter #{permpress_path}/lib/permpress/jshint/formatter.js
            --config .jshintrc
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::JSHint.start(['lint', '--config', '.jshintrc', 'good.js', 'bad.js'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'jshint',
          %w(good.js bad.js),
          %W(
            --reporter #{permpress_path}/lib/permpress/jshint/formatter.js
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::JSHint.start(['lint', 'good.js', 'bad.js'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.js', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['jshint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:2:13::E031:error:Bad assignment.\n"\
          "#{file}:2:13::W030:warning:Expected an assignment or function call and instead saw an expression.\n"\
          "#{file}:2:14::W033:warning:Missing semicolon.\n"\
          "#{file}:2:15::W030:warning:Expected an assignment or function call and instead saw an expression.\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.js', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['jshint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
