module Counter
  class Base
    
    attr_accessor :response
    attr_accessor :body
    attr_accessor :result

    def current_count(group, item = nil)
      http = HTTPClient.new
      url = "http://count.io/vb/#{group}/"
      url += "#{item}/" unless item.nil?
      @response = http.post url
      @body = @response.body 
      @result = JSON.parse(@body)
    end

  end
end
