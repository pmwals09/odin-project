module Enumerable
  def my_each_with_index
    i = 0
    for el in self do
      yield(el, i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    for el in self do
      result << el if yield el
    end
    result
  end

  def my_all?
    pass = true
    for el in self
      unless yield el
        pass = false
      end
    end
    pass
  end

  def my_any?
    for el in self
      if yield el
        return true
      end
    end
    false
  end

  def my_none?
    pass = true
    for el in self
      if yield el
        pass = false
      end
    end
    pass
  end

  def my_count
    count = 0
    for el in self
      if block_given?
        count += 1 if yield el
      else
        count += 1
      end
    end
    count
  end

  def my_map
    new_arr = []
    for el in self
      new_el = yield el
      new_arr << new_el
    end
    new_arr
  end

  def my_inject(initial_value)
    total_value = initial_value ? initial_value : self[0]
    for el in self
      total_value = yield(total_value, el)
    end
    total_value
  end
end


# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for el in self do
      yield el
    end
    self
  end
end
