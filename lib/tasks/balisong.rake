namespace :balisong do
  namespace :db do
    desc "Create content database (location is configurable in config/environments/*)"
    task :create => :environment do
      puts "Creating content database in #{GitModel.db_root}..."
      GitModel.create_db!
    end
  end
end
