require 'spec_helper'

describe Permpress::CoffeeLint do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'coffeelint',
          %w(good.coffee bad.coffee),
          %W(
            --reporter=#{permpress_path}/lib/permpress/coffeelint/lintci.coffee
            --nocolor
            --file=coffeelint.json
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::CoffeeLint.start(['lint', '--config', 'coffeelint.json', 'good.coffee', 'bad.coffee'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'coffeelint',
          %w(good.coffee bad.coffee),
          %W(
            --reporter=#{permpress_path}/lib/permpress/coffeelint/lintci.coffee
            --nocolor
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::CoffeeLint.start(['lint', 'good.coffee', 'bad.coffee'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.coffee', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['coffeelint', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:1:::camel_case_classes:error:Class names should be camel cased\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.coffee', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['coffeelint', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
