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
				when "5"
					age_filter = "between"
				else
					age_filter = "="
				end

				filter += "age #{age_filter} #{tmp["age"]}"
				filter += "and #{tmp["age2"]}" if tmp["age2"]
			when "state"
				filter += "state = '#{tmp["state"]}'"
			when "job"
				filter += "job = '#{tmp["job"]}'"
			end
		end

		return filter
	end
end