module Enumerable
  def my_each()
    return to_enum(:my_each) unless block_given?

    arr = *self # if a range is given, it splats it into an array
    size.times do |indx|
      yield arr[indx]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = *self # if a range is given, it splats it into an array
    size.times do |indx|
      yield arr[indx], indx
    end
    self
  end

  def my_select
    return to_enum(:my_each) unless block_given?

    selected_elements = []
    my_each do |k|
      selected_elements.push(k) if yield k
    end
    selected_elements
  end

  def my_all?(*param)
    if param.length.positive?
      if param[0].class == Regexp
        my_each do |ele|
          return false unless param[0].match(ele)
        end
        return true
      elsif param[0].class == Class
        my_each do |ele|
          return false unless ele.is_a?(param[0])
        end
        return true
      end
    end

    # returns false if a block is not given and falsy element is found
    my_each { |ele| return false unless ele || block_given? }
    return true unless block_given?

    my_each do |ele|
      # returns false if an element that doesn't satsify the condition is found
      return false unless yield ele
    end
    true
  end

  def my_any?
    my_each do |ele|
      return true if yield ele
    end
    false
  end

  def my_none?
    my_each do |ele|
      return false if yield ele
    end
    true
  end

  def my_count
    count = 0
    my_each do |ele|
      count += 1 if yield ele
    end
    count
  end

  def my_map(*param, &block)
    # can accept either a proc or a block, and if both are provided,
    # only uses a proc
    new_array = []
    if param.length.positive?
      proc = param[0] # proc object
    elsif param.length.zero? && block
      proc = block # proc object
    end

    my_each do |ele|
      new_array.push(proc.call(ele))
    end
    new_array
  end

  def my_inject(*param)
    if param.length.positive?
      # provides optional parameter for default value of accumulator
      accumulator = param[0]
      i = 0
    elsif param.length.zero?
      accumulator = first
      i = 1
    end
    (i..(length - 1)).my_each do |indx|
      accumulator = yield accumulator, self[indx]
    end
    accumulator
  end
end
