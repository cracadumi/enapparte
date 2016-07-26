namespace :db do
	desc "Set all performers available for the next 2 months"
	task :set_all_performers_available_For_next_2_month => :environment do ## rake db:set_all_performers_available_For_next_2_month
		User.performers.each do |user|
			puts "--------- Set availabilities for #{user.email} ------------"
			((Time.zone.now.to_date)..(Time.zone.now.to_date + 2.month)).to_a.each do |date|
				user.availabilities.find_or_create_by(available_at: date)
			end
		end
	end
end
