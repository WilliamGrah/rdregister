class Contact < ActiveRecord::Base
	validates :name,	presence: true
	validates :email,	uniqueness: true, presence: true
	validates :age,		presence: true
	validates :state,	presence: true
	validates :job,		presence: true

	before_validation :downcase_email

	private
	def downcase_email
		self.email = self.email.downcase
	end
end
