class ContactsController < ApplicationController
	def index
		filter = []
		if params.has_key?("filter")
			tmp = JSON.parse(params['filter'])

			filter = FilterHelper.prepare_filter(tmp)

			filter = filter.join(" #{tmp["operator"]} ")
		end

		if !filter.empty?
			@contacts = Contact.where(filter)
		else
			@contacts = Contact.all
		end

	end

	def show
	end

	def new
		@contact = Contact.new
	end

	def edit
		@contact = Contact.find(params[:id])
	end

	def create
		@contact = Contact.new(contact_params)
		if @contact.save
			redirect_to contacts_path
		else
			render 'new'
		end
	end

	def update
		@contact = Contact.find(params[:id])

		if @contact.update(contact_params)
			redirect_to contacts_path
		else
			render 'edit'
		end
	end

	def destroy
		@contact = Contact.find(params[:id])
		@contact.destroy

		redirect_to contacts_path
	end

	def filter
		render json: {message: "Testando apenas"}
	end

	private
	def contact_params
		params.require(:contact).permit(:name, :email, :age, :state, :job)
	end
end
