module FiltersHelper
	def self.prepare_query params
		tmp = []
		array = JSON.parse(params['filter'])
		array.each do |hash|
			tmp << prepare_filter(hash)
		end

		return tmp.join(" #{params["operator"]} ")
	end

	def self.prepare_filter tmp
		filter = ""
		tmp.each do |key|
			case key[0]
			when "age"
				case tmp["age_filter"]
				when "1"
					age_filter = ">"
				when "2"
					age_filter = ">="
				when "3"
					age_filter = "<"
				when "4"
					age_filter = "<="
				else
					age_filter = "="
				end

				filter += "lower(age) #{age_filter} #{tmp["age"].downcase}"
			when "state"
				filter += "lower(state) = '#{tmp["state"].downcase}'"
			when "job"
				filter += "lower(job) = '#{tmp["job"].downcase}'"
			end
		end

		return filter
	end
end