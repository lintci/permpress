require 'spec_helper'

describe Permpress::Checkstyle do
  describe '#lint', :unit do
    let(:permpress_path){File.expand_path('../../..', __FILE__)}

    context 'when config flag is present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'java',
          %w(Good.java bad.java),
          %W(
            -jar #{permpress_path}/lib/permpress/checkstyle/checkstyle_logger-all.jar
            -c checks.xml
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::Checkstyle.start(['lint', '--config', 'checks.xml', 'Good.java', 'bad.java'])
      end
    end

    context 'when config flag is not present' do
      it 'executes command with expected arguments' do
        expect(Permpress::Command).to receive(:new).with(
          'java',
          %w(Good.java bad.java),
          %W(
            -jar #{permpress_path}/lib/permpress/checkstyle/checkstyle_logger-all.jar
            -c #{permpress_path}/lib/permpress/checkstyle/sun_checks.xml
          )
        ).and_return(instance_double(Permpress::Command, run: nil))

        Permpress::Checkstyle.start(['lint', 'Good.java', 'bad.java'])
      end
    end
  end

  describe '#lint', :integration do
    include_context 'observed output'

    context 'when the file is not lint free' do
      let(:file){File.expand_path('../../fixtures/bad.java', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['checkstyle', 'lint', file])}.to_not exit_successfully

        expect($stdout.string).to eq(
          "#{file}:1:0::com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck:error:"\
          "Missing a Javadoc comment.\n"\
          "#{file}:1:14::com.puppycrawl.tools.checkstyle.checks.naming.TypeNameCheck:error:"\
          "Name 'bad' must match pattern '^[A-Z][a-zA-Z0-9]*$'.\n"
        )
      end
    end

    context 'when the file is lint free' do
      let(:file){File.expand_path('../../fixtures/Good.java', __FILE__)}

      it 'generates the expected output' do
        expect{Permpress::CLI.start(['checkstyle', 'lint', file])}.to exit_successfully

        expect($stdout.string).to eq('')
      end
    end
  end
end
