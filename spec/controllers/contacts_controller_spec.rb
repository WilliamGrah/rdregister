require "rails_helper"

RSpec.describe ContactsController, :type => :controller do
	describe "GET #index" do
		it "responds succeffuly" do
			get :index

			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the index template" do
			get :index

			expect(response).to render_template("index")
		end

		it "loads all of the contacts into @contacts" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")

			get :index

			expect(assigns(:contacts)).to match_array([contact1, contact2])
		end


		it "loads all of the contacts that match the params filter" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")

			get :index, filter: '[{"age":"26", "age_filter":"1"},{"operator":"and"}]'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact1])
		end

		it "loads all of the contacts that match the params query" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")

			get :index, query: 'age = 18'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact2])
		end
	end

	describe "GET #new" do
		it "responds succeffuly" do
			get :new

			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			get :new

			expect(response).to render_template("new")
		end
	end

	describe "GET #edit" do
		it "responds succeffuly" do
			contact = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")

			get :edit, :id => contact.id

			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the edit template" do
			contact = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			get :edit, :id => contact.id

			expect(response).to render_template("edit")
		end
	end

	describe "PATCH #edit" do
		it "update the contact information" do
			contact = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			patch :update, id: contact.id, contact: {age: 27}

			contact = Contact.find(contact.id)

			expect(contact.age).to eq(27)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(contacts_path)
		end

		it "will not update the contact and will redirect to edit page" do
			contact = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			patch :update, id: contact.id, contact: {name: nil}

			expect(response).to have_http_status(422)
			expect(response).to render_template("edit")
		end
	end

	describe "POST #create" do
		it "create a new contact" do
			contacts = Contact.all
			expect(contacts.count).to eq(0)

			post :create, contact: { name: "Barry Allen", email: "barry@flash.com", age: 28, state: "MO", job: "Police Officer" }

			contacts = Contact.all
			expect(contacts.count).to eq(1)

			expect(response).to have_http_status(302)
			expect(response).to redirect_to(contacts_path)
		end

		it "will not create a user and will redirect to #new" do
			contact = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			
			post :create, contact: { name: "Barry Allen", email: "barry@flash.com", age: 28, state: "MO", job: "Police Officer" }

			contacts = Contact.all
			expect(contacts.count).to eq(1)

			expect(response).to have_http_status(422)
			expect(response).to render_template("new")
		end
	end

	describe "DELETE #destroy" do
		it "delete the contact" do
			contact = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			delete :destroy, :id => contact.id

			contacts = Contact.all
			expect(contacts.count).to eq(0)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(contacts_path)
		end
	end

	describe "Test some possibilities of queries" do
		it "return the age match equals" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")

			get :index, query: 'age = 18'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact2])
		end

		it "return the age match bigger than" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")
			contact3 = Contact.create(name:"Bruce Wayne",email:"bruce@batman.com",age:50,state:"NY",job:"Rich Guy")

			get :index, query: 'age > 28'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact3])
		end


		it "return the age match bigger or equals than" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")
			contact3 = Contact.create(name:"Bruce Wayne",email:"bruce@batman.com",age:50,state:"NY",job:"Rich Guy")

			get :index, query: 'age >= 28'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact1, contact3])
		end


		it "return the age match lower than" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")
			contact3 = Contact.create(name:"Bruce Wayne",email:"bruce@batman.com",age:50,state:"NY",job:"Rich Guy")

			get :index, query: 'age < 28'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact2])
		end

		it "return the age match lower or equals than" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"MO",job:"Student")
			contact3 = Contact.create(name:"Bruce Wayne",email:"bruce@batman.com",age:50,state:"NY",job:"Rich Guy")

			get :index, query: 'age <= 28'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact1, contact2])
		end

		it "returns the state match" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"DC",job:"Student")

			get :index, query: 'state = "MO"'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact1])
		end

		it "returns the job match" do
			contact1 = Contact.create(name:"Barry Allen",email:"barry@flash.com",age:28,state:"MO",job:"Police Officer")
			contact2 = Contact.create(name:"Wally West",email:"wally@kidflash.com",age:18,state:"DC",job:"Student")

			get :index, query: 'job = "Student"'

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(assigns(:contacts)).to match_array([contact2])
		end
	end
end