# In ruby you can call your own exceptions:

require 'net/http'
class Net::HTTPInternalServerError
  def exception(message="Internal server error")
    RuntimeError.new(message) 
  end
end

class Net::HTTPNotFound
  def exception(message="Not Found")
    RuntimeError.new(message)
  end
end

response = Net::HTTP.get_response(URI.parse("http://avdi.org/notexist"))

if response.code.to_i >= 400
  raise response 
end
