require 'test_helper'
 
class CounterItemTest < ActiveSupport::TestCase

  test "initialize me" do
    item = Counter::Item.new("test_group", "test")
    assert_equal('test_item', item.name)
    assert_equal('test_group', item.group)
  end

  test "count success" do
    item = Counter::Item.new("tests", "tests")
    puts item.count
    puts item.response
  end

  test "count fail" do
    item = Counter::Item.new("test_group", "item")
    assert(item.count.nil?)
  end

end  
