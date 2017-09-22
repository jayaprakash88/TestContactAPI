FactoryGirl.define do

  factory :minimal_contact, :class => Hashie::Mash do

    factory :contact do
      id 'c398546d-070e-4b08-b687-681ebed96319'
      email "testapi@mail.com"
      name "TestAPI"
      address 'Bangalore'
      age 25
    end

    factory :contact2 do
      id '0a9b673a-a364-4b74-a3e5-e3dd432e2ae6'
      email "testapi_1@mail.com"
      name "TestAPI_2"
      address 'Chennai'
      age 30
    end
  end
end
