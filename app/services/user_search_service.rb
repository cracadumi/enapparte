class UserSearchService
  def initialize(params)
    # @users = User.all
    @users = User.visible_users
    filter_by_role(params[:role])
    filter_by_art(params[:art_id], params[:req_from_root])
    filter_by_price(params[:price_min], params[:price_max])
    filter_by_available_at(params[:start_date], params[:end_date])
    filter_by_available_at_date(params[:show_date])
  end

  def filter_by_role(role)
    @users = @users.where(role: User.roles[role]) if role.present?
  end

  def filter_by_art(art_id, req_from_root)
    if art_id.present? && Art.find(art_id).title.eql?('Musique - Solo') && req_from_root.present?
      art_ids = [ art_id , Art.find_by_title('Musique - Duo & Groupe').id ]
      @users = @users.where('art_id in (?)',art_ids)
    else
      @users = @users.where(art_id: art_id) if art_id.present?
    end
  end

  def filter_by_available_at(start_date, end_date)
    if end_date
      right_border = DateTime.strptime(end_date, '%d/%m/%Y')
      left_border = start_date ?  DateTime.strptime(start_date, '%d/%m/%Y') : DateTime.now
      all_users = @users
      available_users = @users.joins(:availabilities).where(user_availabilities: { available_at: left_border..right_border })
      non_available_users = (all_users - available_users).uniq
      non_available_users.each {|u| u.unavailable = true}
      @users = (available_users + non_available_users).uniq
    end
  end

  def filter_by_available_at_date(show_date)
    if show_date.present?
      all_users = @users
      available_users =   @users.joins(:availabilities).where(user_availabilities: {available_at: show_date ?  DateTime.strptime(show_date, '%d/%m/%Y') : DateTime.now })
      non_available_users = (all_users - available_users).uniq
      non_available_users.each {|u| u.unavailable = true}
      @users = (available_users + non_available_users).uniq
    end
  end

  def filter_by_price(price_min, price_max)
    return @users if price_min.blank? && price_max.blank?
    if price_min.blank?
      @users = @users.joins(:shows).where('price < ?', price_max).uniq
    elsif price_max.blank?
      @users = @users.joins(:shows).where('price > ?', price_min).uniq
    else
      @users = @users.joins(:shows).where(shows: { price: price_min..price_max }).uniq
    end
  end

  def results
    @users
  end
end
