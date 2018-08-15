require 'byebug'

module Enumerable

  def my_each(&prc)

    idx = 0

    unless prc.nil?
      until idx == self.length
        prc.call(self[idx])
        idx += 1
      end
    else
      return self.to_enum(:my_each)
    end
    self
  end


  def my_each_with_index(&prc)

    idx = 0

    unless prc.nil?
      until idx == self.length
        prc.call(self[idx], idx)
        idx += 1
      end
    else
      return self.to_enum(:my_each)
    end
    self
  end


  def my_select(&prc)

    selection = Array.new

    unless prc.nil?
      self.my_each do |el|
        selection << el if prc.call(el)
      end
    else
      return self.to_enum(:my_each)
    end
    selection
  end


  def my_all?(&prc)

    unless prc.nil?
      self.my_each do |el|
        return false unless prc.call(el)
      end
    else
      return self.to_enum(:my_each)
    end
    true
  end


  def my_any?(&prc)

    unless prc.nil?
      self.my_each do |el|
        return true if prc.call(el)
      end
    else
      return self.to_enum(:my_each)
    end
    false
  end


  def my_none?(&prc)

    unless prc.nil?
      self.my_each do |el|
        return false if prc.call(el)
      end
    else
      return self.to_enum(:my_each)
    end
    true
  end


  def my_count(obj = nil, &prc)
    #debugger
    return self.length if obj.nil? && prc.nil?

    count = 0

    unless prc.nil?
      self.my_each do |el|
        count += 1 if prc.call(el)
      end
    else
      self.my_each do |el|
        count += 1 if el == obj
      end
    end

    count
  end


  def my_map(&prc)

    result = Array.new
    unless prc.nil?
      self.my_each do |el|
        result << prc.call(el)
      end
    else
      return self.to_enum(:my_each)
    end

    result
  end

  def my_map_2(prc = nil)

    result = Array.new
    if !prc.nil?
      #p "proc was run"
      self.my_each do |el|
        result << prc.call(el)
      end
    elsif block_given?
      self.my_each do |el|
        result << yield(el)
      end
    else
      raise "Proc not given AND Block not given!"
    end

    result
  end


  def my_inject(acc = nil, &prc)

    if acc.nil?
      acc = self.first
      arr = self[1..-1]
    else
      arr = self
    end

    unless prc.nil?
      arr.my_each_with_index do |el, idx|
        acc = prc.call(acc, el)
      end
    else
      raise "Block not given!"
    end
    acc
  end

end
