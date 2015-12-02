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
				filter += prepare_filter_age(tmp['age'],tmp['age_filter'])
			when "state"
				filter += "lower(state) = '#{tmp["state"].downcase}'"
			when "job"
				filter += "lower(job) = '#{tmp["job"].downcase}'"
			end
		end

		return filter
	end

	def self.prepare_filter_age age, age_filter
		case age_filter
		when "1"
			operator = ">"
		when "2"
			operator = ">="
		when "3"
			operator = "<"
		when "4"
			operator = "<="
		else
			operator = "="
		end

		return "age #{operator} #{age.downcase}"
	end
end