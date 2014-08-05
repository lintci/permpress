require 'spec_helper'

describe Permpress::RuboCop do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'rubocop',
          %w(good.rb bad.rb),
          %W(
            --require #{permpress_path}/lib/permpress/rubocop/formatter.rb
            --format Permpress::Rubocop::Formatter
            --no-color
            --config .rubocop.yml
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::RuboCop.start(['lint', '--config', '.rubocop.yml', 'good.rb', 'bad.rb'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'rubocop',
          %w(good.rb bad.rb),
          %W(
            --require #{permpress_path}/lib/permpress/rubocop/formatter.rb
            --format Permpress::Rubocop::Formatter
            --no-color
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::RuboCop.start(['lint', 'good.rb', 'bad.rb'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.rb', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['rubocop', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:1:1:5:Style/Documentation:convention:Missing top-level class documentation comment.\n"\
          "#{file}:2:7:4:Style/MethodName:convention:Use snake_case for methods.\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.rb', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['rubocop', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
