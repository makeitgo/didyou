module Counter
  class Base
    
    attr_accessor :response
    attr_accessor :body
    attr_accessor :result
    attr_accessor :group
    attr_reader :errors
    
    def initialize(group)
      @group = group 
      @success = false
      @errors = []
    end

    def success?
      @success
    end

    def summary_count
      post
      result['sum'].to_i if success?
    end

    def post( item = nil, operator = '/', by = nil )
      return unless validate_post_arguments?(group, item, operator, by)
      http = HTTPClient.new
      url = "http://count.io/vb/#{group}/"
      if item.present?
        url += "#{item}#{operator}" 
      end
      begin
        handle_response(http.post url, by.to_i)
      rescue Exception => e
        @errors << e.message
      end
    end

    def validate_post_arguments?(group, item, operator, by)
      @errors << "Group name can not contain 'group'" if group.include?('group')
      @errors << "Item can not contain 'item'" if item.present? && item.include?('item')
      @errors << "/ + and - are the only valid operators" if operator.present? && !['/', '-', '+'].include?(operator)
      @errors << "By must be an integer" if by.present? && !by.is_a?(Numeric)
      @errors.empty?
    end

    private 

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
