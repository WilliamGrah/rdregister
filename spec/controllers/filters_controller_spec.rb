require "rails_helper"

RSpec.describe FiltersController, :type => :controller do
	describe "GET #index" do
		it "responds succeffuly" do
			get :index

			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "render a json with the all filters" do
			filter1 = Filter.create!(name: "filtro 1", query: "age > 15")
			filter2 = Filter.create!(name: "filtro 2", query: "age <= 55")

			get :index

			expect(assigns(:filter)).to match_array([filter1, filter2])
		end
	end

	describe "POST #create" do
		it "will create the filter" do
			post :create, 
			:name => "teste",
			:operator => "and",
			:filter => "[{\"age\":\"28\",\"age_filter\":\"0\"},{\"state\":\"MO\"},{\"job\":\"police officer\"}]"

			expect(response).to be_success
			expect(response).to have_http_status(201)
		end

		it "will raise an error message" do
			post :create, 
			:operator => "and",
			:filter => "[{\"age\":\"28\",\"age_filter\":\"0\"},{\"state\":\"MO\"},{\"job\":\"police officer\"}]"

			expect(response).to have_http_status(500)
		end
	end

	describe "DELETE #destroy" do
		it "will delete the filter" do
			filter = Filter.create!(name: "Filtro", query: "age = 10")

			delete :destroy, :id => filter.id

			expect(response).to have_http_status(200)
		end
	end
end