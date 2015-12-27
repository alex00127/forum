namespace :dev do 
  task :fake => :environment do 
    user = User.first 
    5.times do |i| 
    Topic.create( :title => "Article #{i}", :user => user) 
    end 
  end 
end 