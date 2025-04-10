namespace :db do
    desc "clear database"
    task clear_database: :environment do
      SearchLog.destroy_all
      Session.destroy_all
      User.destroy_all
      Search.destroy_all
    end
end