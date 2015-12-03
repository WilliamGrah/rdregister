require "rails_helper"

RSpec.describe Contact, :type => :model do
	it "set the email to downcase by default" do
		email = "barry@FLASH.com"
		contact = Contact.create!(name:"Barry Allen", email:email, age: 28, state:"MO", job:"Police Officer")
		expect(contact.email).to eq(email.downcase)
	end
end