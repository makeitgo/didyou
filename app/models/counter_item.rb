class CounterItem < ActiveRecord::Base

  belongs_to :counter_group

  def increment(value = 1)
    update_attributes(:count => self.count + value.abs)
  end

  def decrement(value = 1)
    update_attributes(:count => self.count - value.abs)
  end

end
