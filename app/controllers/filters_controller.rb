class FiltersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	def index
		@filter = Filter.all
		array = []
		@filter.each do |ea|
			array << {:id => ea.id, :name => ea.name, :query => ea.query}
		end
		render plain: array.to_json
	end

	def new
		@filter = Filter.new
	end

	def create
		query = FiltersHelper.prepare_query(params)

		if query && params[:name]
			data = {:query => query, :name => params[:name]}
		else
			raise "Errorrrr"
		end

		@filter = Filter.new(data)
		if @filter.save
			render status: 201, plain: "Great Success"
		else
			render status: 400, plain: @filter.errors.full_messages
		end
	end

	def show
	end

	def destroy
		@filter = Filter.find(params[:id])
		@filter.destroy

		render status: 200, plain: 'deleted'
	end

	private
	def filter_params
		params.require(:filter).permit(:query, :name)
	end
end
