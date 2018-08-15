require 'byebug'

class Array

  def bubble_sort

    sorted = false
    until sorted
      sorted = true
      self.each_with_index do |el, idx|
        break if idx == self.length - 1
        if el > self[idx+1]
          self[idx], self[idx+1] = self[idx+1], self[idx]
          sorted = false
        end
      end
    end

    self
  end


  def bubble_sort_by

    sorted = false

    if block_given?
      until sorted
        sorted = true
        self.each_with_index do |el, idx|
          break if idx == self.length - 1
          comparison = yield(el, self[idx + 1])
          if comparison == 1
            self[idx], self[idx + 1] = self[idx + 1], self[idx]
            sorted = false
          end
        end
      end
    else
      raise %q{ Array instance method bubble_sort_by requires a block }
    end

    self
  end

end
