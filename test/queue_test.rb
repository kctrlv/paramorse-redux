require 'minitest/autorun'
require 'minitest/pride'
require '/Users/RyanWorkman/turing/Module1/Projects/ParaMorse/lib/paramorse'
require '/Users/RyanWorkman/turing/Module1/Projects/ParaMorse/lib/morse_queue'

class TestingQueue < Minitest::Test
  def setup
    @q = ParaMorse::MorseQueue.new
  end
  def test_queue_exists
    assert_instance_of MorseQueue, @q
  end
  def test_one_item_can_be_pushed_into_queue
    @q.push('1')
    assert_equal 1, @q.count
  end
  def test_more_than_one_item_can_be_pushed_and_counted_in_a_queue
    @q.push('1')
    @q.push('0')
    assert_equal 2, @q.count
  end
  def test_tail_returns_last_element_to_be_inserted_in_queue
    @q.push('1')
    assert_equal '1', @q.tail
  end
  def test_tail_returns_last_element_of_queue_larger_than_one
    @q.push('1')
    @q.push('0')
    assert_equal '0', @q.tail
  end
  def test_tail_returns_element_at_a_given_space_from_the_back
    @q.push('1')
    @q.push('0')
    assert_equal '1', @q.tail(2)
  end
  def test_tail_returns_element_at_index_in_a_longer_queue
    @q.push('1')
    @q.push('0')
    @q.push('0')
    @q.push('R')
    @q.push('1')
    assert_equal '0', @q.tail(3)
    assert_equal 'R', @q.tail(2)
  end
  def test_queue_returns_at_first_element_in_queue
    @q.push('1')
    assert_equal '1', @q.peek
  end
  def test_queue_returns_element_at_a_given_index_from_the_front
    @q.push('1')
    @q.push('0')
    assert_equal '0', @q.peek(2)
  end
  def test_queue_can_remove_the_first_element
    @q.push('1')
    @q.push('0')
    @q.pop
    assert_equal '0', @q.peek
    assert_equal 1, @q.count
  end
  def test_pop_returns_the_first_element_while_removing_it
    @q.push('1')
    @q.push('0')
    assert_equal '1', @q.pop
    assert_equal '0', @q.peek
    assert_equal 1, @q.count
  end
  def test_queue_can_be_cleared
    @q.push('1')
    @q.push('0')
    @q.clear
    assert_equal 0, @q.count
  end
  def test_queue_can_peek_at_several_elements_from_given_index_from_the_front
    @q.push('1')
    @q.push('0')
    @q.push('0')
    @q.push('R')
    @q.push('1')
    assert_equal ['1', '0', '0', 'R'], @q.peek_multiple(4)
  end
#   q.peek_multiple(3)
# # => ['1', '0', '0']
# q.count
# # => 5
# q.pop
# # => '1'
# q.pop_multiple(3
end
