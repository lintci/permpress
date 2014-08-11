require 'spec_helper'

describe Permpress::RuboCop do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          "#{permpress_path}/lib/permpress/scsslint/scsslint",
          %w(good.scss bad.scss),
          %w(
            --format=LintCI
            --config=.scss-lint.yml
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::SCSSLint.start(['lint', '--config', '.scss-lint.yml', 'good.scss', 'bad.scss'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          "#{permpress_path}/lib/permpress/scsslint/scsslint",
          %w(good.scss bad.scss),
          %w(
            --format=LintCI
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::SCSSLint.start(['lint', 'good.scss', 'bad.scss'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.scss', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['scsslint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:2:3:12:BorderZero:warning:`border: 0;` is preferred over `border: none;`\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.scss', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['scsslint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
