class FinancesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  # GET /finances
  # GET /finances.json
  
  autocomplete :user, :fullname

  def index

    if user_signed_in?
      if current_admin_user
        @finance = Finance.new
#         Get all user names
        @user = User.new
		@team_filter = Array.new
		Team.all.each do |team|
			@team_filter.push [team.name, team.id]
		end
		
        @finances_grid = initialize_grid(Finance,
          :name => 'g1',
          :include => [:user],
          :order => 'finances.id',
          :order_direction => 'desc',
          :enable_export_to_csv => true,
          :csv_file_name => 'KCMSTSMFINANCES')

      else
	  	@team_filter = Array.new
		Team.all.each do |team|
			@team_filter.push [team.name, team.id]
		end
		
        @finances_grid = initialize_grid(Finance,
          :include => [:user],
          :order => 'finances.id',
          :order_direction => 'desc',
          :conditions => "user_id = #{current_user.id}" )
        @total_cash = current_user.finances.sum("cash_amount")
        @total_check = current_user.finances.sum("check_amount")
        @total_amount = @total_cash + @total_check
      end
        export_grid_if_requested('g1' => 'export_grid') do
        respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @finances }
      end
      end
    end
  end

  # GET /finances/1
  # GET /finances/1.json
  def show
    if current_admin_user
      @finance = Finance.find(params[:id])
    else
      @finance = current_user.finances.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @finance }
    end
  end

  # GET /finances/new
  # GET /finances/new.json
  def new
    if current_admin_user
      @finance = Finance.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @finance }
      end
    end
  end

  # GET /finances/1/edit
  def edit
    if current_admin_user
    @finance = Finance.find(params[:id])
    end
  end

  # POST /finances
  # POST /finances.json
  def create
    if current_admin_user
      #@finance = Finance.new(params[:finance])

      @finance = User.find(:all, :conditions => ["fullname = ?", params[:user][:fullname]]).first.finances.new(params[:finance])
      respond_to do |format|
        if @finance.save
          format.html { redirect_to root_path, notice: 'Finance was successfully created.' }
          format.json { render json: @finance, status: :created, location: @finance }
        else
          format.html { render action: "index" }
          format.json { render json: @finance.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /finances/1
  # PUT /finances/1.json
  def update
    if current_admin_user
      @finance = Finance.find(params[:id])

      respond_to do |format|
        if @finance.update_attributes(params[:finance])
          format.html { redirect_to root_path, notice: 'Finance was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @finance.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /finances/1
  # DELETE /finances/1.json
  def destroy
    if current_admin_user
      @finance = Finance.find(params[:id])
      @finance.destroy

      respond_to do |format|
        format.html { redirect_to finances_url }
        format.json { head :no_content }
      end
    end
  end
end
