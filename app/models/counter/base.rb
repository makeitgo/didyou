module Counter
  class Base
    
    attr_accessor :response
    attr_accessor :body
    attr_accessor :result
    attr_accessor :group
    
    def initialize(group)
      @group = group
    end

    def summary_count
      post
      result['sum'].to_i
    end

    def post( item = nil, operator = '/', by = nil )
      http = HTTPClient.new
      url = "http://count.io/vb/#{group}/"
      if item.present?
        url += "#{item}#{operator}" 
      end
      @response = http.post url, by
      @body = response.body 
      @result = JSON.parse(body)
    end

  end

end
