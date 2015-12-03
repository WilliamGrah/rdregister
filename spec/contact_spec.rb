require "./app/models/contact"
require "active_record"

RSpec.describe Contact do
	fixtures :contacts

	describe "GET #index" do
		it "renders the :index view" do
			contacts(:barry)
		end
	end
end