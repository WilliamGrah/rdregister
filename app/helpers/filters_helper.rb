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
				filter += prepare_filter_age(key[0])
			when "state"
				filter += "lower(state) = '#{tmp["state"].downcase}'"
			when "job"
				filter += "lower(job) = '#{tmp["job"].downcase}'"
			end
		end

		return filter
	end

	def prepare_filter_age age
		case age
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

		return "lower(age) #{age_filter} #{tmp["age"].downcase}"
	end
end