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
    assert_respond_to @stream, :receive
  end
  def test_stream_can_decode_data_received
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('0')
    assert_equal 'e', @stream.letter_string
  end
  def test_stream_can_decode_more_than_one_item_received
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('1')
    @stream.receive('1')
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('0')
    assert_equal 'a', @stream.letter_string
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
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('0')
    assert_equal 'ha', @stream.letter_string
  end
  def test_stream_receive_detects_letter
    @stream.receive('1')
    @stream.receive('0')
    @stream.receive('0')
    @stream.receive('0')
    assert_equal 'e', @stream.letter_string
  end
  def test_stream_automatically_dumps_letters
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
    assert_equal 'h', @stream.letter_string
  end
end
