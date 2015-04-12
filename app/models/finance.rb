class Finance < ActiveRecord::Base
  attr_accessible :audit, :cash_amount, :check_amount, :check_number, :data_entry, :date, :notes, :supporter_name, :user_id
  belongs_to :user
  validates :user_id, presence: true


     def auto_complete_list
      #  list = []
      #  for u in User.all
      #    list << u.fullname
      #  end
      #  return list
     end
end
