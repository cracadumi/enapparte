json.merge! @show.attributes
json.user_picture_url @show.try(:user).try(:profile_picture).try(:image).try(:url, :thumb)
json.commission Show::COMMISSION

json.pictures @show.pictures do |picture|
  json.id picture.id
  json.src picture.src
end

json.cover_picture do
  json.id @show.cover_picture.try(:id)
  json.src @show.cover_picture.try(:src)
end

if @show.user.present?
  json.user do
    json.partial! 'api/v1/users/user', user: @show.user
  end
end
