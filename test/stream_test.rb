require 'minitest/autorun'
require 'minitest/pride'
require '../lib/paramorse'
require '../lib/stream_decoder'
class TestStream < Minitest::Test
  def setup
    @stream = ParaMorse::StreamDecoder.new
  end
  def test_stream_exists
    assert_instance_of StreamDecoder, @stream
  end
  def test_stream_can_receive_information
    assert @stream.receive('1')
  end
  def test_stream_can_receive_two_pieces_of_data
    assert @stream.receive('1')
    assert @stream.receive('0')
  end
  def test_stream_can_decode_data_received
    @stream.receive('1')
    assert_equal 'e', @stream.decode
  end
  def test_stream_can_decode_more_than_one_item_received
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('1')
    @stream.receive('1')
    assert_equal 'a', @stream.decode
  end
  def test_stream_can_decode_word_streamed
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('1')
    @stream.receive('1')
    assert_equal 'ha', @stream.decode
  end

  def test_stream_can_encode_letters
    @stream.receive('h')
    @stream.receive('e')
    @stream.receive('l')
    @stream.receive('l')
    @stream.receive('o')
    assert_equal '1010101000100010111010100010111010100011101110111', @stream.encode
  end

  def test_stream_automatically_decodes_letters
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('1')
    @stream.receive('1')
    assert_equal 'h', @stream.letter_queue.tail
    assert_equal 'a', @stream.letter_queue.peek
  end
end
