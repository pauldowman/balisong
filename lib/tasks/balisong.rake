namespace :balisong do
  namespace :db do
    desc "Create content database (location is configurable in config/environments/*)"
    task :create => :environment do
      puts "Creating content database in #{GitModel.db_root}..."
      GitModel.create_db!
    end

  end
end

# Dummy db:test:prepare task since cucumber depends on it but ActiveRecord
# (which normally provides it) isn't installed.
namespace :db do
  namespace :test do
    task :prepare do
      # do nothing
    end
  end
end
