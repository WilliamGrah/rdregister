class Filter < ActiveRecord::Base
	validates :name,	uniqueness: true, presence: true
	validates :query,	presence: true
end
