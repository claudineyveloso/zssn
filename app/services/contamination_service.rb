# frozen_string_literal: true

class ContaminationService
  def initialize(user_id_notified)
    @user_id_notified = user_id_notified
  end

  def update_contamination
    user = User.find_by(id: @user_id_notified)
    if user.contamination_notification == 2
      user.update(contamination_notification: user.contamination_notification + 1, infected: true)
    else
      user.update(contamination_notification: user.contamination_notification + 1)
    end
  end
end
