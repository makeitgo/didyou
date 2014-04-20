module Counter
  class Base
    
    attr_accessor :response
    attr_accessor :body
    attr_accessor :result
    attr_accessor :group
    attr_reader :error
    
    def initialize(group)
      @group = group
      @success = false
    end

    def success?
      @success
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
      begin
        handle_response(http.post url, by)
      rescue Exception => e
        @error = e.message
      end
    end

    def handle_response(http_response)
      if http_response.present?
        if http_response.is_a?(HTTP::Message)
          status = http_response.header.status_code
          @response = http_response
          @body = response.body 
          @result = JSON.parse(body)
          @success = status == 200
        end
      end
    end

  end

end
