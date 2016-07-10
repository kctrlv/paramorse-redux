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
  def test_stream_detects_zeroes
    assert @stream.detect_end_of_letter('0')
  end
  def test_stream_receive_detects_zeroes
    @stream.receive('0')
    assert_equal '00', @stream.detect_end_of_letter('0')
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
    assert_equal '1010101', @stream.send_complete_letter
  end
end
