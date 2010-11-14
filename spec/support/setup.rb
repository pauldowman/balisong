RSpec.configure do |config|
  config.before(:each) do
    GitModel.recreate_db!
  end
end

