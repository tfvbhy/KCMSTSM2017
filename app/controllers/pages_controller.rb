class PagesController < ApplicationController
  def home
  end

  def teamtotals
  	 if user_signed_in?
      if current_admin_user
        @finances_grid = initialize_grid(Finance,
          :include => [:user])
        @total_cash = Finance.sum("cash_amount")
        @total_check = Finance.sum("check_amount")
        @total_amount = @total_cash + @total_check

		@team_total_cash = Array.new(Team.all.size, 0);
		@team_total_check = Array.new(Team.all.size, 0);
		@team_total_amount = Array.new(Team.all.size, 0);

        @leader_total_cash = 0
        @leader_total_check = 0

        @all_leader_indexes = []

        User.all.each do |user|
          #puts in all leaders index
		  @team_total_cash[user.team.to_i - 1] += user.finances.sum("cash_amount")
		  @team_total_check[user.team.to_i - 1] += user.finances.sum("check_amount")
		end
		Team.all.each do |team|
			@team_total_amount[team.id - 1] = @team_total_cash[team.id - 1] + @team_total_check[team.id - 1]
		end
        #works with leaders being "Admins"
        for i in @all_leader_indexes
          @leader_total_cash += User.find(i).finances.sum("cash_amount")
          @leader_total_check += User.find(i).finances.sum("check_amount")
        end
        @leader_total_amount = @leader_total_cash + @leader_total_check
      end
    end
  end
  
  def teammanagement
	if user_signed_in?
      if current_user.leader
		@member_total_cash = Array.new(current_user.team.size, 0);
		@member_total_check = Array.new(current_user.team.size, 0);
		@member_total_amount = Array.new(current_user.team.size, 0);
		
#		User.find_by_team(current_user.team) do |u|
#			@member_total_cash[0] = u.finances.sum("cash_amount")
#			@member_total_check[0] = u.finances.sum("check_amount")
#			@member_total_amount[0] = @member_total_cash + @member_total_check
#		end
		
		@teammanagement_grid = initialize_grid(User,
          :name => 'g3',
          :order => 'users.id',
          :order_direction => 'desc',
          :enable_export_to_csv => true,
          :csv_file_name => 'KCMSTSMUSERS')
	  end
	end
  end
end
