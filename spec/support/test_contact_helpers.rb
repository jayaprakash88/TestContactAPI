def delete_test_contacts
  delete 'contact_data/delete_by_email', {}, params: {email: attributes_for(:contact)[:email]}
end

def create_test_contacts
  post 'contact_data', attributes_for(:contact)
end
