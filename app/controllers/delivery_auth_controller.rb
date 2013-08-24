require 'open-uri'
#testing
 class AuthController < ApplicationController
   def delivery
      app_id = "OWE5NDg1YzM0NTk3NDczNGM0NzQ1ZGM5N2ZkNzQzNWNj"
      redirect_uri = "http://localhost:3000/"
      code = params[:key]
      endpoint_url = "https://www.delivery.com/api/api.php?key=#{app_id}&method=delivery&street=#{address1}&zip=#{postal}"
      result = open(endpoint_url).read
      parsed_result = Rack::Utils.parse_query(result)
      current_user.save
      redirect_to user_url(current_user)
   end
 end
