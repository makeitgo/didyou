class CounterGroup < ActiveRecord::Base
  
  has_many :counter_items

  def summary_count
    counter_items.inject(0) { |value, item| value += item.count }
  end
  
  def item(name)
    if !counter_items.exists?(name: name)
      counter_items.create(name: name, count: 0)
    end
    counter_items.where(name: name)
  end

end

