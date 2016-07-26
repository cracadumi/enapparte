namespace :users do
  desc 'update existing user to visible'
  task set_existing_users_visible: :environment do
    User.all.each do|user|
      user.update_attribute('visible',true)
    end
  p '-----------{Existing users updated with visible attribute}---------------'
  end
end
