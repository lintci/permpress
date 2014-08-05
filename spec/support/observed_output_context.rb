RSpec.shared_context 'observed output' do
  around(:each) do |example|
    $stdout, out = StringIO.new, $stdout
    $stderr, err = StringIO.new, $stderr

    example.run

    $stdout, $stderr = out, err
  end
end
