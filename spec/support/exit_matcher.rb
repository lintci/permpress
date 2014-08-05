RSpec::Matchers.define :exit_successfully do
  match do |actual|
    begin
      actual.call
    rescue SystemExit => system_exit
      system_exit.success?
    else
      false
    end
  end

  def supports_block_expectations?
    true
  end
end
