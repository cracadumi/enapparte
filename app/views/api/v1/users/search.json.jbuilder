json.array! @users do |user|
  json.id user.id
  json.firstname user.firstname
  json.surname user.surname
  json.full_name user.full_name
  json.art_id user.art_id
  json.art_title user.art.try(:title) || '-'
  json.rating user.rating
  json.availabilities user.availabilities do |availability|
    json.available_at availability.available_at
  end
  json.picture_url user.profile_picture.image
end
