# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  age                        :integer          not null
#  contamination_notification :integer          default(0)
#  gender                     :string(20)       not null
#  infected                   :boolean          default(FALSE)
#  is_active                  :boolean          default(TRUE)
#  latitude                   :string(255)      not null
#  longitude                  :string(255)      not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class User < ApplicationRecord
end
