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

  test "summary_count" do
    counter = Counter::Base.new("test")
    counter.post
    assert_equal(true, counter.success?)
    assert(counter.summary_count.present?)
  end

  test "summary_count not successful" do
    counter = Counter::Base.new("")
    puts counter.summary_count
    assert_equal(false, counter.success?)
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

  test "validate post arguments" do
    counter = Counter::Base.new("test")
    assert(counter.validate_post_arguments?('good', 'good', '/', 0))
    assert_equal(0, counter.errors.size)

    assert(!counter.validate_post_arguments?('group', 'item', '$', 'a'))
    assert_equal(4, counter.errors.size)
  end


end
