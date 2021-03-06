# == Schema Information
#
# Table name: devices
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  internal_name :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Device < ApplicationRecord
  has_many :media, class_name: 'Media', dependent: :destroy

  validates :bytes_capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
