require "rails_helper"

RSpec.describe FiltersHelper, :type => :helper do
	describe "#prepare_query" do
		it "prepare the query to be filtered" do
			brute = {"name"=>"teste", "operator"=>"and", "filter"=>"[{\"age\":\"28\",\"age_filter\":\"0\"},{\"state\":\"MO\"},{\"job\":\"police officer\"}]"}
			result = "age = 28 and lower(state) = 'mo' and lower(job) = 'police officer'"
			expect(FiltersHelper.prepare_query(brute)).to eq(result)
		end

		it "prepare query with age_filter equal to 1" do
			result = "age > 28"
			expect(FiltersHelper.prepare_filter_age(28,1)).to eq(result)
		end

		it "prepare query with age_filter equal to 2" do
			result = "age >= 28"
			expect(FiltersHelper.prepare_filter_age(28,2)).to eq(result)
		end

		it "prepare query with age_filter equal to 3" do
			result = "age < 28"
			expect(FiltersHelper.prepare_filter_age(28,3)).to eq(result)
		end

		it "prepare query with age_filter equal to 4" do
			result = "age <= 28"
			expect(FiltersHelper.prepare_filter_age(28,4)).to eq(result)
		end

		it "prepare query with age_filter anything else" do
			result = "age = 28"
			expect(FiltersHelper.prepare_filter_age(28,"tg32gwg")).to eq(result)
		end
	end
end