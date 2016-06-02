class UserSearchService
  def initialize(params)
    @users = User.all
    filter_by_role(params[:role])
    filter_by_art(params[:art_id])
    filter_by_available_at(params[:start_date], params[:end_date])
  end

  def filter_by_role(role)
    @users = @users.where(role: User.roles[role]) if role.present?
  end

  def filter_by_art(art_id)
    @users = @users.where(art_id: art_id) if art_id.present?
  end

  def filter_by_available_at(start_date, end_date)
    if end_date
      right_border = DateTime.strptime(end_date, '%d/%m/%Y')
      left_border = start_date ?  DateTime.strptime(start_date, '%d/%m/%Y') : DateTime.now
      @users = @users.joins(:availabilities).where(user_availabilities: { available_at: left_border..right_border })
    end  
  end

  def results
    @users
  end
end
