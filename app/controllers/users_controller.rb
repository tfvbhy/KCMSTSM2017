class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :adminOnly, except: []

#  def index
#    @users = User.excludes(:id => current_user.id)
#  end

#  def new
#    @user = User.new
#  end

#  def create
#    @user = User.new(params[:user])
#    if @user.save
#      flash[:notice] = "Successfully created User." 
#      redirect_to root_path
#    else
#      render :action => 'new'
#    end
#  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
	  params[:user].delete(:password)
	  params[:user].delete(:password_confirmation)
	end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated User."
      redirect_to editusers_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if current_admin_user
      @user = User.find(params[:id])
	  @user.finances.destroy_all
      if @user.destroy
        flash[:notice] = "Successfully deleted User."
        redirect_to root_path
      end
	end
  end 
  
  def editusers
	@team_filter = Array.new
	Team.all.each do |team|
		@team_filter.push [team.name, team.id]
	end
	
	@school_filter = Array.new
	School.all.each do |school|
		@school_filter.push [school.name, school.id]
	end
	@editusers_grid = initialize_grid(User,
      :name => 'g2',
      :order => 'users.id',
      :order_direction => 'desc',
      :enable_export_to_csv => true,
      :csv_file_name => 'KCMSTSMUSERS')
  end
  
  def adminOnly
	redirect_to root_path, notice: "Not authorized" if !current_user.admin?
  end
end