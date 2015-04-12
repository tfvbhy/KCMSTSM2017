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

		@team_total_cash = Array.new(Team.all.size + 1, 0);
		@team_total_check = Array.new(Team.all.size + 1, 0);
		@team_total_amount = Array.new(Team.all.size + 1, 0);

        @leader_total_cash = 0
        @leader_total_check = 0

        @all_leader_indexes = []

        User.all.each do |user|
          #puts in all leaders index
          if user.admin == true
            @all_leader_indexes << user.id
          end
		  @team_total_cash[user.team.to_i] += user.finances.sum("cash_amount")
		  @team_total_check[user.team.to_i] += user.finances.sum("check_amount")
		end
		Team.all.each do |team|
			@team_total_amount[team.id] = @team_total_cash[team.id] + @team_total_check[team.id]
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
end
