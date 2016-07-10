class MorseQueue
  def initialize
    @queue = Array.new
  end

  def push(input)
    @queue << input
  end

  def count
    @queue.length
  end

  def tail(index = 1)
    return @queue[-1] if index == 1
    @queue[@queue.length - index]
  end

  def peek(index = 1)
    index -= 1
    @queue[index]
  end

  def pop
    @queue.shift
  end

  def clear
    @queue = Array.new
  end

  def empty?
    @queue.length == 0
  end
end
