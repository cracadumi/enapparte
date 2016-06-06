json.id @user.id
json.art do
  json.banner_url @user.art.banner_url
  json.title @user.art.title
end
json.full_name @user.full_name
json.rating @user.rating
json.activity @user.activity

json.profile_picture do
  json.id @user.profile_picture.try(:id)
  json.src @user.profile_picture.try(:src)
end

json.available_languages @user.available_languages
