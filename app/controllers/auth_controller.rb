require 'open-uri'

 class AuthController < ApplicationController
   def delivery
      app_id = "OWE5NDg1YzM0NTk3NDczNGM0NzQ1ZGM5N2ZkNzQzNWNj"
      @endpoint_url = "https://www.delivery.com/api/api.php?key=#{app_id}&method=delivery&street=#{current_user.address1}&zip=#{current_user.postal}"
      result = open(endpoint_url).read
      @parsed_result = Rack::Utils.parse_query(result)
      redirect_to user_url(current_user)
   end
 end
