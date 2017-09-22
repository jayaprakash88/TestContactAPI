require 'spec_helper'
require 'cgi'

describe 'ContactsAPI' do

  before(:each) do
    create_test_contacts
  end

  after(:each) do
    delete_test_contacts
  end

  context 'Get contact' do
    it 'based on id (UUID)' do
      contact = attributes_for(:contact)
      get "contact_data/show/#{contact[:id]}"
      expect_status(200)
      expect_json(email: contact[:email],
                  age: contact[:age],
                  address: contact[:address],
                  name: contact[:name])
    end

    it 'based on email' do
      contact = attributes_for(:contact)
      get 'contact_data/by_email', params: {email: contact[:email]}
      expect_status(200)
      expect_json(email: contact[:email],
                  age: contact[:age],
                  address: contact[:address],
                  name: contact[:name])
    end

    it "gives the error code 404 for finding wrong id(UUID)" do
      random_uuid = SecureRandom.uuid
      get "contact_data/show/#{random_uuid}"
      expect_status(404)
    end

    it "gives the error code 404 for finding mail id " do
      contact2 = attributes_for(:contact2)
      get 'contact_data/by_email', params: {email: contact2[:email]}
      expect_status(404)
    end
  end
end

describe 'ContactsAPI Create' do

  it "error 422 creates a new contact without mail id" do
    contact2 = attributes_for(:contact2)
    contact2[:email] = ""
    post 'contact_data', contact2
    expect_status(422)
  end

  it "error 422 creates a new contact unformat mail id" do
    contact2 = attributes_for(:contact2)
    contact2[:email] = "testmail"
    post 'contact_data', contact2
    expect_status(422)
  end

  it "error 422 creates a new contact age as string" do
    contact2 = attributes_for(:contact2)
    contact2[:age] = ""
    post 'contact_data', contact2
    expect_status(422)
  end

  it "creates a new contact" do
    contact2 = attributes_for(:contact2)
    post 'contact_data', contact2
    expect_status(201)
    expect_json(email: contact2[:email],
                age: contact2[:age],
                address: contact2[:address],
                name: contact2[:name])
  end

  it 'gives error for duplicate UUID' do
    contact2 = attributes_for(:contact2)
    post 'contact_data', contact2
    expect_status(422)
  end

  it 'gives error for duplicate Email' do
    contact2 = attributes_for(:contact2)
    post 'contact_data', contact2
    expect_status(422)
  end

  it 'update and returns status 200 by mail id' do
    contact2 = attributes_for(:contact2)
    update_params = { email: contact2[:email], age: "50" }
    put "contact_data/update_by_email", {}, params: update_params
    expect_status(200)
  end

  it 'update and returns status 200 by uuid' do
    contact2 = attributes_for(:contact2)
    update_params = { id: contact2[:id], age: "50" , address: "Mumbai"}
    put "contact_data/update_by_email", {}, params: update_params
    expect_status(200)
  end

  it 'error returns status 422 for updating age as string' do
    contact = attributes_for(:contact2)
    update_params = { email: contact[:email], age: "age" }
    put "contact_data/update_by_email", {}, params: update_params
    expect_status(422)
  end

  it "delete contact by mail id" do
    contact2 = attributes_for(:contact2)
    delete_params =   {email: contact2[:email]}
    delete 'contact_data/delete_by_email', {}, params: delete_params
    expect_status(200)
  end

  it "delete contact by uuid" do
    create_test_contacts
    contact = attributes_for(:contact)
    delete_params =   {id: contact[:id]}
    delete 'contact_data/delete_by_email', {}, params: delete_params
    expect_status(200)
  end

end