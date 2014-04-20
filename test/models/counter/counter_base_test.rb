require 'test_helper'
 
class CounterBaseTest < ActiveSupport::TestCase
   test "default post" do
     Counter::Base.new('test')
     


   end
end
