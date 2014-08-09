require 'spec_helper'

describe Permpress::CSSLint do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'csslint',
          %w(good.css bad.css),
          %W(
            --errors=#{Permpress::CSSLint::RULES}
            --format=compact
            --config=.csslintrc
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::CSSLint.start(['lint', '--config', '.csslintrc', 'good.css', 'bad.css'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'csslint',
          %w(good.css bad.css),
          %W(
            --errors=#{Permpress::CSSLint::RULES}
            --format=compact
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::CSSLint.start(['lint', 'good.css', 'bad.css'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.css', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['csslint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}: line 2, col 5, Error - Using width with border can sometimes make elements larger than you expect.\n\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.css', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['csslint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq("#{file}: Lint Free!\n")
      end
    end
  end
end
