# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
	belongs_to :user
	has_many :archives

	accepts_nested_attributes_for :archives

	validates :group_name, presence: true
	validates_associated :archives
end
