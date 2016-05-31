json.merge! @user.attributes
json.language_ids @user.language_ids
json.gender @user.gender

json.profile_picture do
  json.id @user.profile_picture.try(:id)
  json.src @user.profile_picture.try(:src)
end

json.addresses @user.addresses do |address|
  json.merge! address.attributes
  json.full_address address.full_address
end

json.reviews @user.reviews.includes(booking: [user: [:profile_picture, :ratings]]) do |review|
  json.merge! review.attributes
  json.userImageUrl review.try(:booking).try(:user).try(:profile_picture).try(:image).try(:url, :thumb)
  json.bookingUserFullName review.try(:booking).try(:user).try(:full_name)
  json.bookingUserRating review.try(:booking).try(:user).try(:rating)
end

json.sent_reviews @user.sent_reviews do |review|
  json.merge! review.attributes
  json.userImageUrl review.try(:booking).try(:user).try(:profile_picture).try(:image).try(:url, :thumb)
  json.bookingUserFullName review.try(:booking).try(:user).try(:full_name)
  json.bookingUserRating review.try(:booking).try(:user).try(:rating)
end

json.payment_methods @user.payment_methods do |payment_method|
  json.merge! payment_method.attributes
end

json.available_languages  User.available_languages do |language|
  json.merge! language.attributes
end