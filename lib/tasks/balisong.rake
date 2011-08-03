namespace :balisong do
  namespace :db do
    desc "Create content database (location is configurable in config/environments/*)"
    task :create => :environment do
      puts "Creating content database in #{GitModel.db_root}..."
      GitModel.create_db!
    end

    desc "Create/update GitModel indexes (required after each change to the data)"
    task :index => :environment do
      branch = `ref=$(git symbolic-ref HEAD 2> /dev/null); echo ${ref#refs/heads/}`.chomp
      puts "Creating index for branch #{branch}"
      GitModel.index!(branch)
    end
  end
end

