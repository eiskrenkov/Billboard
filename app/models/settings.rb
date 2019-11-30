# == Schema Information
#
# Table name: settings
#
#  id          :integer          not null, primary key
#  service_url :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Settings < ApplicationRecord
  scope :instance, -> { last }
end
