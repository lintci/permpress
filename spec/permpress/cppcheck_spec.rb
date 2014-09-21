require 'spec_helper'

describe Permpress::CppCheck do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    it 'executes command with expected arguments' do
      expect(Permpress::Command).to receive(:new).with(
        'cppcheck',
        %w(good.cpp bad.cpp),
        %w(
          --enable=all
          --error-exitcode=1
          --template="{file}:{line}:::{id}:{severity}:{message}"
        )
      ).and_return(instance_double(Permpress::Command, run: nil))

      Permpress::CppCheck.start(['lint', 'good.cpp', 'bad.cpp'])
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.cpp', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['cppcheck', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "Checking #{file}...\n" \
          "Checking usage of global functions..\n" \
          "#{file}:11:::unusedFunction:style:The function 'get42' is never used.\n" \
          "::::missingInclude:information:Cppcheck cannot find all the include files (use --check-config for details)"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/good.cpp', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['cppcheck', 'lint', file])}.to exit_successfully
        expect($stdout.string).to eq("Checking #{file}...\nChecking usage of global functions..\n")
      end
    end
  end
end
