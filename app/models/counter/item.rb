module Counter
  class Item < Counter::Base

    attr_accessor :name

    def initialize(group, name)
      @name = name
      super(group)
    end

    def count
      post(name)
      @result['count'].to_i if success?
    end

    def increment(by = nil)
      post(name, '+', post_variable('IncrementBy', by))
    end

    def decrement(by = nil)
      post(name, '-', post_variable('DecrementBy', by))
    end

    def post_variable(name, value)
      {name => value} if value.present?
    end

  end
end
