require 'test_helper'
 
class CounterItemTest < ActiveSupport::TestCase

  test "initialize me" do
    item = Counter::Item.new("test_group", "test")
    assert_equal('test_item', item.name)
    assert_equal('test_group', item.group)
  end

  test "count success" do
    item = Counter::Item.new("test_group", "test")
    assert(item.count.present?)
  end
end  
