require 'test_helper'
 
class CounterBaseTest < ActiveSupport::TestCase
  

  test "initialize me" do
    counter = Counter::Base.new('test')
    assert_equal(false, counter.success?)
    assert_equal('test', counter.group)
  end

  test "success?" do
    counter = Counter::Base.new('test')
    assert_equal(false, counter.success?)
    counter.instance_variable_set(:@success, true)
    assert_equal(true, counter.success?)
  end

    #SecureRandom.uuid
  test "post group" do
    counter = Counter::Base.new("test")
    counter.post
    assert_equal(true, counter.success?)
    assert(counter.response.present?)
    assert(counter.body.present?)
    assert(counter.result.present?)
    assert(counter.result['sum'].present?)
  end

  test "post group item" do
    counter = Counter::Base.new("test")
    counter.post('test')
    assert_equal(true, counter.success?)
    assert(counter.response.present?)
    assert(counter.body.present?)
    assert(counter.result.present?)
    assert(!counter.result['sum'].present?)
    assert(counter.result['count'].present?)
  end

  test "post group item /" do
    counter = Counter::Base.new("test")
    counter.post('test', '/')
    assert_equal(true, counter.success?)
    assert(counter.response.present?)
    assert(counter.body.present?)
    assert(counter.result.present?)
    assert(!counter.result['sum'].present?)
    assert(counter.result['count'].present?)
  end

  test "post group item operator +" do
    counter = Counter::Base.new("test")
    counter.post('test')
    assert_equal(true, counter.success?)
    assert(counter.result['count'].present?)
    pre_count = counter.result['count']
    counter.post('test', '+')
    post_count = counter.result['count']
    assert_equal(pre_count + 1 , post_count)
  end

  test "post group item operator -" do
    counter = Counter::Base.new("test")
    counter.post('test')
    assert_equal(true, counter.success?)
    assert(counter.result['count'].present?)
    pre_count = counter.result['count']
    counter.post('test', '-')
    post_count = counter.result['count']
    assert_equal(pre_count - 1 , post_count)
  end

  test "post group item bad operator" do
    counter = Counter::Base.new("test")
    counter.post('test', 'bad')
    assert_equal(false, counter.success?)
  end
end
