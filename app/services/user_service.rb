# frozen_string_literal: true

# class
class UserService
  def initialize(user=nil)
    @user = user
  end

  def self.create_user_with_inventory(user_params)
    user = User.new(user_params)
    user.create_inventory if user.save
    user
  end

  def report_infected
    user = User.find_by(id: @user_id_notified)
    if user.contamination_notification == 2
      user.update(contamination_notification: user.contamination_notification + 1, infected: true)
    else
      user.update(contamination_notification: user.contamination_notification + 1)
    end
  end
end
