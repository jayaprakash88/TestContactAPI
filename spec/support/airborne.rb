require 'airborne'

Airborne.configure do |config|
  config.base_url = 'http://localhost:3000/api/v2/'
  # config.rack_app = API
  config.headers = {'CONTENT_TYPE' => 'application/json'}
end
